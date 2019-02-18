#!/usr/bin/env python
# coding: utf-8

# ## Lab Session 03 - OpenCV with Python submission
# <p>NGUYEN Thanh-Long </p>
# <p>nguyenta@eurecom.fr </p>

# In[1]:


import cv2
import numpy as np


# In[7]:


from PIL import Image, ImageFilter


# In[8]:


path="/Users/longng/Google Drive/EURECOM/Semester 1 - FALL 2018/03 IMPROC - Digital Image Processing/Lab/20181023 Week 4/Baboon.jpg"
img = cv2.imread(path)


# In[16]:


cv2.imshow('Original',img)
cv2.waitKey(0)
cv2.destroyAllWindows() #press esc to exit


# **Call the appropriate function in OPENCV to convert the image to grayscale**

# In[10]:


gray = cv2.cvtColor(img, cv2.COLOR_BGR2GRAY)


# **Create a window called "Grayscale Image" and show grayscale image**
# 

# In[18]:


cv2.imshow('Grayscale Image',gray)
cv2.waitKey(0)
cv2.destroyAllWindows()


# **Apply histogram equalization to the grayscale image**

# In[22]:


equ = cv2.equalizeHist(gray)


# **Create a window called "Image After Histogram Equalization" and show the image after histogram equalization**

# In[23]:


cv2.imshow('Image After Histogram Equalization',equ)
cv2.waitKey(0)
cv2.destroyAllWindows()


# **Apply upside down operation to the image for which histogram equalization is applied.**

# In[24]:


horizontal_img = cv2.flip(equ, 0)


# **Create a window called "Remap - upside down" and show the image after applying remapping - upside down**

# In[25]:


cv2.imshow('Remap - upside down',horizontal_img)
cv2.waitKey(0)
cv2.destroyAllWindows()


# **Apply reflection in the x direction operation to the image for which histogram equalization is applied.**

# In[28]:


vertical_img = cv2.flip(equ,1)


# **Create a window called "Remap - reflection in the x direction" and show the image after applying remapping - reflection in the x direction**

# In[29]:


cv2.imshow('Remap - reflection in the x direction',vertical_img)
cv2.waitKey(0)
cv2.destroyAllWindows()


# **Apply Median Filter to the Image for which histogram equalization is applied**

# In[36]:


median = cv2.medianBlur(equ,5)


# **Create a window called "Median Filtered Image" and show the image after applying median filtering**

# In[37]:


cv2.imshow('Median Filtered Image',median)
cv2.waitKey(0)
cv2.destroyAllWindows()


# **Remove noise from the image for which histogram equalization is applied by blurring with a Gaussian filter**

# In[50]:


blur = cv2.GaussianBlur(equ,(3,3),5)


# **Create a window called "Gaussian Filtered Image" and show the image after applying Gaussian filtering**

# In[51]:


cv2.imshow('Gaussian Filtered Image',blur)
cv2.waitKey(0)
cv2.destroyAllWindows()


# **Apply Laplace function to compute the edge image using the Laplace Operator**

# In[145]:


laplacian = cv2.Laplacian(blur,cv2.CV_16S,ksize=3,scale=1, delta=0)
lapl = cv2.convertScaleAbs(laplacian)


# **Create window called "Laplace Demo" and show the edge image after applying Laplace Operator**

# In[146]:


cv2.imshow('Laplace Demo',lapl)
cv2.waitKey(0)
cv2.destroyAllWindows()


# Apply Sobel Edge Detection

# **Compute Gradient X**

# In[94]:


sobelx = cv2.Sobel(blur,cv2.CV_16S,1,0,3,ksize=3,scale=1, delta=0)
grad_x = cv2.convertScaleAbs(sobelx)


# **Compute Gradient Y**

# In[95]:


sobely = cv2.Sobel(blur,cv2.CV_64F,0,1,3,ksize=3,scale=1, delta=0)
grad_y = cv2.convertScaleAbs(sobely)


# **Compute Total Gradient (approximate)**

# In[96]:


grad=cv2.addWeighted(grad_x, 0.5, grad_y, 0.5, 0)


# **Create window called "Sobel Demo - Simple Edge Detector" and show Sobel edge detected image**

# In[98]:


cv2.imshow('Sobel Demo - Simple Edge Detector',grad)
cv2.waitKey(0)
cv2.destroyAllWindows()


# **Export images**

# In[148]:


grayc = cv2.cvtColor(gray,cv2.COLOR_GRAY2BGR)
equc = cv2.cvtColor(equ,cv2.COLOR_GRAY2BGR)
horizontal_imgc = cv2.cvtColor(horizontal_img,cv2.COLOR_GRAY2BGR)
vertical_imgc = cv2.cvtColor(vertical_img,cv2.COLOR_GRAY2BGR)
medianc = cv2.cvtColor(median,cv2.COLOR_GRAY2BGR)
blurc = cv2.cvtColor(blur,cv2.COLOR_GRAY2BGR)
laplc = cv2.cvtColor(lapl,cv2.COLOR_GRAY2BGR)
gradc = cv2.cvtColor(grad,cv2.COLOR_GRAY2BGR)


# In[156]:


output1 = np.hstack((img, grayc, equc))
output2 = np.hstack((horizontal_imgc, vertical_imgc, medianc))
output3 = np.hstack((blurc, laplc, gradc))
output = np.concatenate((output1, output2, output3), axis=0)
cv2.imwrite('NGUYEN_Thanh_Long_Lab03_image_output_report_python3.jpg',output)

