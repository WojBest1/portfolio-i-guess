#include <Keypad.h>
#include <LiquidCrystal.h>

const byte ROWS = 4; // Four rows
const byte COLS = 4; // Four columns

bool notSpec = false;
const int MAX_ITEMS = 40; // Maximum number of items in the list
String itemList[MAX_ITEMS]; // Array to store items
String letters[MAX_ITEMS]; // Array to store items
String symbols[MAX_ITEMS]; // Array to store items

int itemCount = 0; // Number of items currently in the list
int itemCount2 = 0;

// Define the symbols on the buttons of the keypads
char hexaKeys[ROWS][COLS] = {
  {'1','2','3','A'},
  {'4','5','6','B'},
  {'7','8','9','C'},
  {'*','0','#','D'}
};

byte rowPins[ROWS] = { 2, 4, A0, A1 }; // Connect to the row pinouts of the keypad
byte colPins[COLS] = { A2, A3, A4, A5 }; // Connect to the column pinouts of the keypad

LiquidCrystal lcd(7, 8, 9, 10, 11, 12);

// Initialize an instance of class Keypad
Keypad customKeypad = Keypad(makeKeymap(hexaKeys), rowPins, colPins, ROWS, COLS);

int colum = 0;
int row = 0;

void setup() {
    Serial.begin(9600);
    lcd.begin(16, 2);
}

void loop() {
    char customKey = customKeypad.getKey();
    lcd.setCursor(colum, row);

    if (colum == 16) {
        row++;
        colum = 0;
    }




    if (customKey == 'A')
    {
        notSpec = true;

        addItemToList(String("+")); // Convert char to String and add to list
        lcd.print("+");
        colum++;


    }



    if (customKey == 'B')
    {
        notSpec = true;

        addItemToList(String("-")); // Convert char to String and add to list
        lcd.print("-");
        colum++;


    }


    if (customKey == 'C')
    {
        notSpec = true;

        addItemToList(String("*")); // Convert char to String and add to list
        lcd.print("*");
        colum++;

    }


    if (customKey == 'D')
    {
        notSpec = true;

        addItemToList(String("/")); // Convert char to String and add to list
        lcd.print("/");
        colum++;

    }

  
   if (customKey == '#') {
        int up = 0;
        int track = 0;

        for (int i = 0;i < 2;i++)
        {

            while (up < itemCount ) 
            {

                if(itemList[up] == "-")
                {
                          addLetterToList(itemList[up]);
                             up++;
                }
                addLetterToList(itemList[up]);
             
                up++;

            if (itemList[up] == "+" || itemList[up] == "-" || itemList[up] == "*" || itemList[up] == "/")
            {
              
                addsymbolsToList(itemList[up]);
                 up++;
                itemCount2++;

            }
 
            }
  
       
       

        }
 

        
int newnum = itemCount2 + 1;

int i = 0;
while (letters[1] != "") {

    for (i = 0; i <= newnum; i++) 
    {
      
        if (symbols[i] == "/") {        
 
           float calc = letters[i].toFloat()/ letters[i + 1].toFloat();
            letters[i + 1] = "";       
            letters[i] = String(calc);         
            symbols[i] = "";
            shuffleDownletters();
            shuffleDownsybols();
            i = -1; // Reset i to -1 so it becomes 0 after i++
        } else if (symbols[i] == "*") {
            float calc = letters[i + 1].toDouble() * letters[i].toDouble(); 
            letters[i + 1] = "";
            letters[i] = String(calc);
            symbols[i] = "";
            shuffleDownletters();
            shuffleDownsybols();
            i = -1; // Reset i to -1 so it becomes 0 after i++
        }
    }

    int ii = 0;
    for (ii = 0; ii <= newnum; ii++) {
        if (symbols[ii] == "-") {
           double calc = letters[ii].toDouble() - letters[ii + 1].toDouble();
            letters[ii + 1] = "";        
            letters[ii] = String(calc);       
            symbols[ii] = "";
            shuffleDownletters();
            shuffleDownsybols();
            ii = -1; // Reset ii to -1 so it becomes 0 after ii++
        } else if (symbols[ii] == "+") {
            double calc = letters[ii + 1].toDouble() + letters[ii].toDouble();       
            letters[ii + 1] = "";
            letters[ii] = String(calc);
            symbols[ii] = "";
            shuffleDownletters();
            shuffleDownsybols();
            ii = -1; // Reset ii to -1 so it becomes 0 after ii++
        }
    }
}


  lcd.clear();
  lcd.print(letters[0].toFloat(), 3);


  up = 0;

        clearList();


    }


    if (customKey == '*') { // Check if a key is pressed

        lcd.clear();
        colum = 0;
        row = 0;


    }



    if (customKey != '\0' && notSpec == false && customKey != '#' && customKey != '*') { // Check if a key is pressed

        addItemToList(String(customKey)); // Convert char to String and add to list
        lcd.print(customKey);
        colum++;
       
    }



    notSpec = false;

}



void addLetterToList(String newItem) {
    if (itemCount2 < MAX_ITEMS) {
        letters[itemCount2] += newItem; // Add item to the list

    }
    else {
        Serial.println("List is full!"); // Handle case where list is full
    }
}



void addsymbolsToList(String newItem) {
    if (itemCount2 < MAX_ITEMS) {
        symbols[itemCount2] += newItem; // Add item to the list

    }
    else {
        Serial.println("List is full!"); // Handle case where list is full
    }
}

 



void addItemToList(String newItem) {
    if (itemCount < MAX_ITEMS) {
        itemList[itemCount] = newItem; // Add item to the list
        itemCount++; // Increment item count
    }
    else {
        Serial.println("List is full!"); // Handle case where list is full
    }
}








void clearList() {
    itemCount = 0; // Reset itemCount to clear the list
      itemCount2 = 0; // Reset itemCount2 to clear the list
 for (int i = 0; i < MAX_ITEMS; i++) {
        symbols[i] = "";
    }
    for (int i = 0; i < MAX_ITEMS; i++) {
        letters[i] = "";
    }
}


void shuffleDownletters() {


    int usedCount = 0;
    int numLetters = sizeof(letters) / sizeof(letters[0]); // Calculate number of elements

    for (int i = 0; i < numLetters; i++) {
        if (letters[i].length() > 0) {
            usedCount++;
        }
    }

        for (int i = 0; i < usedCount; i++) {

 if(letters[i] == "")
      {
              

        letters[i] = letters[i+1]; 
          

         letters[i+1] = "";

      }
     
    }
}


void shuffleDownsybols() {
    int usedCount2 = 0;
    int numLetters = sizeof(letters) / sizeof(letters[0]); // Calculate number of elements

    for (int i = 0; i < numLetters; i++) {
        if (letters[i].length() > 0) {
            usedCount2++;
        }
    }

    for (int i = 0; i < usedCount2; i++)
     {
      if(symbols[i] == "")
      {
        symbols[i] = symbols[i+1];
         symbols[i+1] = "";

      }
   
    }

    
}
