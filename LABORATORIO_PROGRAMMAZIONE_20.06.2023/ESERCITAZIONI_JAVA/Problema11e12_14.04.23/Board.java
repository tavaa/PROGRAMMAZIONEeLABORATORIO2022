/**
 * UniUd - Programmazione e laboratorio - 2022-2023
 * 154255 - Tavano Matteo
 * Esercitazione 3-4 in Java
 */

import java.util.function.*;

public class Board {
    
  private static final String ROWS = " 123456789ABCDEF";
  private static final String COLS = " abcdefghijklmno";
  
  private final int size;
  private final int queens;
  
  private final SList<Integer> row;
  private final SList<Integer> col;
  private final SList<Integer> dg1;
  private final SList<Integer> dg2;
  
  private final String config;
  
  
  public Board( int n ) {
      
    size = n;
    queens = 0;
    row = new SList<Integer>();
    col = new SList<Integer>();
    dg1 = new SList<Integer>();
    dg2 = new SList<Integer>();
    config = " ";
  }
  
  private Board( Board b, int i, int j ) {
      
    size = b.size();
    queens = b.queensOn()+1;
    
    row = b.row.cons(i);
    col = b.col.cons(j);
    dg1 = b.dg1.cons(i-j);
    dg2 = b.dg2.cons(i+j);
    config = b.arrangement() + " " + COLS.charAt(j) + ROWS.charAt(i);
  }
  
  
  public int size(){
    return size;
  }
  
  
  public int queensOn(){
    return queens;
  }
  
  
  public boolean underAttack(int i, int j){
    return(
            SList.findElement( row,i )   ||
            SList.findElement( col,j )   ||
            SList.findElement( dg1,i-j ) ||
            SList.findElement( dg2,i+j )
          );
  }
  
  
  public String arrangement(){
    
    return config;
  }
  
  
  public Board addQueen( int i, int j ) {
    
      return new Board( this, i, j );
  }
  
  
  public String toString(){ 
    
    return arrangement(); 
  }
  
} // class Board
