import pandas as pd
from sqlalchemy import create_engine
import time

def run_etl_pipeline():
    print("Starting ETL Pipeline...")
    start_time = time.time()

    # 1. EXTRACT: Sirf zaroori columns read kar rahe hain memory bachane ke liye
    file_path = r"E:\project\Raw_data\accepted_2007_to_2018Q4.csv\accepted_2007_to_2018Q4.csv"
    
    columns_to_keep = [
        'id', 'loan_amnt', 'term', 'int_rate', 'grade', 'emp_length', 
        'home_ownership', 'annual_inc', 'issue_d', 'loan_status', 'purpose', 'dti'
    ]
    
    print("Extracting data from CSV...")
    # Dataset bada hai, testing ke liye nrows=500000 use kar sakte hain. Pura load karne ke liye nrows hata dein.
    df = pd.read_csv(file_path, usecols=columns_to_keep, low_memory=False, nrows=500000)

    # 2. TRANSFORM: Data Cleaning & Feature Engineering
    print("Cleaning and Transforming data...")
    
    # Missing values handle karna
    df['emp_length'] = df['emp_length'].fillna('Unknown')
    df['annual_inc'] = df['annual_inc'].fillna(df['annual_inc'].median())
    df['dti'] = df['dti'].fillna(df['dti'].median())
    
    # Loan Status ko simplify karna (Sirf clear default aur paid loans par focus)
    valid_statuses = ['Fully Paid', 'Charged Off', 'Default']
    df = df[df['loan_status'].isin(valid_statuses)]
    
    # Naya Business Logic Column: Risk_Category
    def categorize_risk(row):
        if row['dti'] > 30 and row['annual_inc'] < 50000:
            return 'High Risk'
        elif row['dti'] > 20:
            return 'Medium Risk'
        else:
            return 'Low Risk'
            
    df['Risk_Category'] = df.apply(categorize_risk, axis=1)

    # 3. LOAD: MySQL Database me insert karna
    print("Loading data into MySQL Database...")
    
    # Yahan apna MySQL username (usually 'root') aur password dalein
    db_user = 'root'
    db_password = '2005' # <--- YAHAN APNA PASSWORD DALEIN
    db_host = 'localhost'
    db_name = 'credit_risk_db'
    
    engine = create_engine(f"mysql+pymysql://{db_user}:{db_password}@{db_host}/{db_name}")
    
    # Data ko SQL table me push karna. Table khud ban jayegi.
    df.to_sql(name='loan_portfolio', con=engine, if_exists='replace', index=False, chunksize=10000)
    
    end_time = time.time()
    print(f"ETL Pipeline Completed Successfully in {round(end_time - start_time, 2)} seconds!")
    print(f"Total Rows Loaded: {len(df)}")

if __name__ == "__main__":
    run_etl_pipeline()