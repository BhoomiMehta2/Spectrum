from PIL import Image

def crop_center_squircle(input_path, output_path):
    img = Image.open(input_path)
    width, height = img.size
    
    # Define the bounding box for the central squircle
    # The squircle is centered. We crop a box of size 670x670 centered.
    crop_size = 670
    left = (width - crop_size) // 2
    top = (height - crop_size) // 2
    right = left + crop_size
    bottom = top + crop_size
    
    cropped_img = img.crop((left, top, right, bottom))
    
    # Resize back to 1024x1024 for crispness
    final_img = cropped_img.resize((1024, 1024), Image.Resampling.LANCZOS)
    final_img.save(output_path, "PNG")
    print("Successfully cropped and resized the icon!")

if __name__ == "__main__":
    crop_center_squircle(
        "/Users/bhoomimehta/.gemini/antigravity-ide/brain/f99aaa9e-2f25-42b9-bdae-dc68e877b5af/app_icon_1024_minimal_1784312194334.png",
        "/Users/bhoomimehta/Desktop/converter/ThemeForge/Resources/Assets.xcassets/AppIcon.appiconset/app_icon_1024.png"
    )
