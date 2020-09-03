### Electrical-Circuit-Identification

## Intro

In this project I identified an electrical circuit which operates an brushless DC electric motor using its Input and Output data.In the first image we can see the BLDC motor and in the second image we can see de system model.

![BLDCmotor](https://user-images.githubusercontent.com/41568927/92150719-8672e280-ee28-11ea-8425-753d031743b6.JPG)

![system model](https://user-images.githubusercontent.com/41568927/92150760-98ed1c00-ee28-11ea-8f20-ac9f21333eef.JPG)

## Input and output data

In the next image we can see the ploted data which I used to generate an mathemathical model using ARX, ARMAX, IV and OE methods.
![InputANDoutput data](https://user-images.githubusercontent.com/41568927/92151118-42cca880-ee29-11ea-9349-f05e0ab8d2ae.JPG)

## Using the data

We can see that in the speed plot, near the zero value we have some errors and the best way to solve them is using interpolation like in the next image:

![speedInter](https://user-images.githubusercontent.com/41568927/92151412-bec6f080-ee29-11ea-94fa-4fee1d85f800.JPG)

After that step I had selected the data in two categories: 
        * Indentification data ( Red color )
        * Validation data ( Green color )
  
