from PIL import Image

# Dono images ke naam yahan daalein
img1_path = "photo_2026-08-23_00-30-12.jpg"
img2_path = "photo_2026-08-23_00-30-10.jpg"

img1 = Image.open(img1_path)
img2 = Image.open(img2_path)

# Power BI ribbon aur taskbar ko crop karne ke estimates (Top se 150px, Bottom se 50px)
# Aap inhe apne hisaab se thoda adjust kar sakte hain agar zaroorat ho
crop_box = (0, 150, img1.width, img1.height - 50) 

img1_cropped = img1.crop(crop_box)
img2_cropped = img2.crop(crop_box)

# Naya blank image create karein (Height dono images ki combined hogi)
total_height = img1_cropped.height + img2_cropped.height
new_img = Image.new('RGB', (img1_cropped.width, total_height))

# Dono cropped images ko naye canvas par paste karein
new_img.paste(img1_cropped, (0, 0))
new_img.paste(img2_cropped, (0, img1_cropped.height))

# Final collage save karein
new_img.save("Dashboard_Preview.png")
print("Collage successfully created and saved as Dashboard_Preview.png!")