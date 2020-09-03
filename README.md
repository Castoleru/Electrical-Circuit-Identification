### Electrical-Circuit-Identification

## Intro

In this project, I identified an electrical circuit that operates a brushless DC electric motor using its Input and Output data. In the first image, we can see the BLDC motor and in the second image, we can see the de system model.

![BLDCmotor](https://user-images.githubusercontent.com/41568927/92150719-8672e280-ee28-11ea-8425-753d031743b6.JPG)

![system model](https://user-images.githubusercontent.com/41568927/92150760-98ed1c00-ee28-11ea-8f20-ac9f21333eef.JPG)

## Input and output data

In the next image, we can see the plotted data which I used to generate a mathematical model using ARX, ARMAX, IV and OE methods.

![InputANDoutput data](https://user-images.githubusercontent.com/41568927/92151118-42cca880-ee29-11ea-9349-f05e0ab8d2ae.JPG)

## Using the data

We can see that in the speed plot, near the zero value we have some errors and the best way to solve them is using interpolation like in the next image:

![speedInter](https://user-images.githubusercontent.com/41568927/92151412-bec6f080-ee29-11ea-94fa-4fee1d85f800.JPG)

After that step I had selected the data into two categories: 
1. Identification data ( Red color )
2. Validation data ( Green color )
  
![DataSelection](https://user-images.githubusercontent.com/41568927/92151813-63493280-ee2a-11ea-8132-4569a2679d0e.JPG)

After using all methods and testing then I found two models, one based on intercorrelation and one based on autocorrelation. Here are the models:

![Results](https://user-images.githubusercontent.com/41568927/92152028-ba4f0780-ee2a-11ea-85a5-7b87258ba711.JPG)


PS: For more details please read the "(Romanian)Proiect_Identificarea unei axe actionate cu motor BLDC" file. I am sorry because the document is written in Romanian, but I will translate it soon.
