In this Microsoft SQL Server query, I have created an art gallery database (AGD).

I have created three tables tblAuthors, which stores authors whose works reside in the gallery;
tblPaintings, which stores the paintings from said authors; and, tblEstimatedValue which is a 
table that by using a procedure stores arbitrary value estimation of the paintings. 

The table tblAuthors is connected to tblPaintings, and the tblPainting is connected to tblEstimatedValue.

The feature of this project is the value estimator. I have created a function that takes in paramters: 
previousOwnerNo - the number of the prevoius owners of the painting;
conditionOf - the condition of the painting, set to an arbitrary scoring system using values from 0.00 to 100.00, 
inclusive (0.00 being unrepairable, and 100.00 being in excellent condition);
authenticity - refers to whether the painting is an original or not. If it is an original, then the paramter value
should be set at 1, conversly, if it is not an original, the value should be set to 0.
The function then returns the price as a decimal with a precision of 8 and scale of 2.  

Next step was to make this function as dynamic as possible. Which is why I have incorporated the function inside
the procedure sp_EstimateValue. This procedure takes in these paramters: paintingID, previousOwnerNo, conditionOf, 
authenticity, price and inserts them in the tblEstimatedValue table. However, the price is not given as a parameter - 
it is determined based on the parameters given by us through the function and then inserted in the table by the 
procedure. 

I have then have created two user-defined procedures: sp_insertAuthors and sp_insertPaintings which insert values
given into their respective tables. 

Then, I have created a join statement to see the paintings in the gallery and the names of their authors.

Next step, I created another join statment to see the title of the painting, its price, and the author id. 

Finally, I have done a backup of the database, just in case.