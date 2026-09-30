library(tesseract)

# Set the path to the Tesseract executable (optional, if it's not in your PATH)
# Sys.setenv(TESSERACT_CMD = "path_to_tesseract_executable")

# Perform OCR on an image
text <- ocr("build_composite_share_data.png")

# Print the extracted text
print(text)
