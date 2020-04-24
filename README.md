## Geting Started

First things first.  Run `rspec` in the terminal to make sure everything is working.

Then, you can run the calculator with the following command:
```
ruby calculator.rb -h
```
This will return a list of valid insurance types.  You can then run:
```
ruby calculator.rb {insruance_type} -h
```
This will return the required parameters for the given `insurance_type`


## Some Thoughts
I made a few assumptions in building this:
1. That insurance calculations are actually MUCH more complicated
2. That the multipliers and prices are subject to change

Due to the first assumption I decided to keep the calculators completely separate.  While it looks
like there may have been some opportunities to make them more DRY, as they are quite similar, I did not think it would
be worth the trade off.  Once those classes become more complicated having them rely on some form of inheritance or
common code would quickly become a headache.

Due to the second assumption I decided to keep all the multipliers and prices completely abstracted from the actual
calculators.  This way a proper database, or any other source of data, can be swapped in easily.

I also tried to keep the terminal interface layer as dumb as possible.  It is really the bare minimum for what is needed
to provide a command line interface.  This way the business logic does not bleed into the view layer which allows other
view layers to be plugged in easily.

As for validations...  I am sure there are opportunities to improve the current implementation (zip_code for example).
Though, to really validate things such as zip code you need to know the country.  As well, if the user is expected to use
 a command line interface as opposed to a web browser, I think we can expect them to be more kind with their inputs.

For specs I used a different environment so that the spec data will remain constant.  We should be able to change our
multipliers and prices in production without specs breaking.

There is definitely more opportunities for playing code golf here but I think we can save that for when we discuss
my implimentation.

 ## Some Concerns

 The results of the formula don't seem right...  As well, if tax is 0% percent I am not sure what the desired result is.
 Should the price be 0?  Or should it not change the price?  If it didn't change the price that would be equivalent to a tax
 multiplier of 100%.  Anyways, for the sake of the challenge I implemented the formula exactly as specified.