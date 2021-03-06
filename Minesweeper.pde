import de.bezier.guido.*;
private int NUM_ROWS =20; 
private int NUM_COLS = 20;
private MSButton[][] buttons; //2d array of minesweeper buttons
private ArrayList <MSButton> mines= new ArrayList <MSButton>(); //ArrayList of just the minesweeper buttons that are mined

void setup ()
{
    size(400, 400);
    textAlign(CENTER,CENTER);
    
    // make the manager
    Interactive.make( this );
    
    //your code to initialize buttons goes here
    buttons = new MSButton[NUM_ROWS][NUM_COLS];
    for(int r = 0; r<NUM_ROWS ; r++){
        for(int c =0 ; c<NUM_COLS; c++){
            buttons[r][c]= new MSButton(r,c);
        }
    }
    
    setMines();
}
public void setMines()
{
    for(int i=0;i<100;i++){
 int Mrow=(int)(Math.random()*NUM_ROWS);
 int Mcol=(int)(Math.random()*NUM_COLS);
if(!mines.contains(buttons[Mrow][Mcol]))
    mines.add(buttons[Mrow][Mcol]);
}
}

public void draw ()
{
    background( 0 );
    if(isWon() == true)
        displayWinningMessage();
}
public boolean isWon()
{
    //your code here
    return false;
}
public void displayLosingMessage()
{
    //your code here
}
public void displayWinningMessage()
{
    //your code here
}
public boolean isValid(int r, int c)
{
  return r<NUM_ROWS&&c<NUM_COLS&&r>=0&&c>=0;
}
public int countMines(int row, int col)
{
 int count = 0;
  if(isValid(row-1,col-1)&&mines.contains(buttons[row-1][col-1]))
    count++;
  if(isValid(row-1,col)&&mines.contains(buttons[row-1][col]))
    count++;
  if(isValid(row-1,col+1)&&mines.contains(buttons[row-1][col+1]))
    count++;
  if(isValid(row,col-1)&&mines.contains(buttons[row][col-1]))
    count++;
  if(isValid(row,col+1)&&mines.contains(buttons[row][col+1]))
    count++;
  if(isValid(row+1,col-1)&&mines.contains(buttons[row+1][col-1]))
    count++;
  if(isValid(row+1,col)&&mines.contains(buttons[row+1][col]))
    count++;
  if(isValid(row+1,col+1)&&mines.contains(buttons[row+1][col+1]))
    count++;
  return count; 
}
public class MSButton
{
    private int myRow, myCol;
    private float x,y, width, height;
    private boolean clicked, flagged;
    private String myLabel;
    
    public MSButton ( int row, int col )
    {
        width = 400/NUM_COLS;
        height = 400/NUM_ROWS;
        myRow = row;
        myCol = col; 
        x = myCol*width;
        y = myRow*height;
        myLabel = "";
        flagged = clicked = false;
        Interactive.add( this ); // register it with the manager
    }

    // called by manager
    public void mousePressed () 
    {
        clicked = true;
        if(mouseButton==RIGHT){
            if(flagged==false)
                clicked=false;
            flagged=!flagged;
        }
        else if(mines.contains(this)){
            textAlign(CENTER);
            text("You Lose :(",width/2,height/2);
        }
        else if(countMines(myRow,myCol)>0)
            setLabel(countMines(myRow,myCol));
        else {
            for(int r = myRow-1; r<=myRow+1;r++)
                for(int c = myCol-1; c<=myCol+1;c++)
                    if(isValid(r,c)&&!buttons[r][c].clicked)
                        buttons[r][c].mousePressed();

        }

    }
    public void draw () 
    {    
        if (flagged)
            fill(0);
        else if( clicked && mines.contains(this) ) 
         fill(255,0,0);
        else if(clicked)
            fill( 200 );
        else 
            fill( 100 );

        rect(x, y, width, height);
        fill(0);
        text(myLabel,x+width/2,y+height/2);
    }
    public void setLabel(String newLabel)
    {
        myLabel = newLabel;
    }
    public void setLabel(int newLabel)
    {
        myLabel = ""+ newLabel;
    }
    public boolean isFlagged()
    {
        return flagged;
    }
}
