import os
import pytesseract
import time
from PIL import Image
import pyperclip

# Create the 'log' folder if it doesn't exist
if not os.path.exists('log'):
    os.makedirs('log')
    

# List all image files in the 'img' folder
image_files = [f for f in os.listdir('img') if f.lower().endswith(('.png', '.jpg', '.jpeg', '.gif', '.bmp'))]
recent_txt_file_content = None  # To store the most recent txt file content

for image_file in image_files:
    image_path = os.path.join('img', image_file)
    image = Image.open(image_path)
    
    # Perform OCR using pytesseract
    detected_text = pytesseract.image_to_string(image)
    
    # Create a corresponding log file
    log_filename = os.path.splitext(image_file)[0] + '.txt'
    log_path = os.path.join('log', log_filename)
    recent_txt_file_content = detected_text
    
    with open(log_path, 'w') as log_file:
        log_file.write(detected_text)
    
    print(f"Text from '{image_file}' saved to '{log_filename}'")
    
    # Wait for a moment to make sure the file-writing process is complete
    time.sleep(1)

# Copy content to clipboard using pyperclip
if recent_txt_file_content:
    pyperclip.copy(recent_txt_file_content)
    print("Content copied to clipboard.")
    
    # Wait for a moment to make sure the copying process is complete
    time.sleep(1)

# Remove all files from 'log' folder
for log_file in os.listdir('log'):
    os.remove(os.path.join('log', log_file))

# Wait for a moment to make sure the file-removal process is complete
time.sleep(1)

# Remove all files from 'img' folder
for img_file in os.listdir('img'):
    os.remove(os.path.join('img', img_file))

print("OCR, logging, and cleanup complete.")
