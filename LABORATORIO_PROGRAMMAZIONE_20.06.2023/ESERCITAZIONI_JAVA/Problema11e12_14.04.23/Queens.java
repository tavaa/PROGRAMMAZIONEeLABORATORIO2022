/**
 * UniUd - Programmazione e laboratorio - 2022-23
 * 154255 - Tavano Matteo
 * Esercitazione 3-4 in Java
 */

import queens.*;
import java.util.*;

public class Queens {

  public static final SList<Board> NULL_BOARDLIST = new SList<Board>();

  
  public static int numberOfSolutions( int n ) {
    
    return numberOfCompletions( new Board(n) );
  }
  
  
  private static int numberOfCompletions( Board b ) {
  
    int n = b.size();
    int q = b.queensOn();
    
    if ( q == n ) {
    
      return 1;
    
    } else {
    
      int i = q + 1;
      int count = 0;
      
      for ( int j=1; j<=n; j=j+1 ) {
        if ( !b.underAttack(i,j) ) {
        
          count = count + numberOfCompletions( b.addQueen(i,j) );
      }}
      return count;
    }
  }
  
  
  public static SList<Board> listOfAllSolutions( int n ) {
  
    return listOfAllCompletions( new Board(n) );
  }
  
  
  private static SList<Board> listOfAllCompletions( Board b ) {
  
    int n = b.size();
    int q = b.queensOn();
    
    if ( q == n ) {
    
      return ( NULL_BOARDLIST.cons(b) );
    
    } else {
    
      int i = q + 1;
      SList<Board> solutions = NULL_BOARDLIST;
      
      for ( int j=1; j<=n; j=j+1 ) {
        if ( !b.underAttack(i,j) ) {
        
          solutions = solutions.append( listOfAllCompletions(b.addQueen(i,j)) );
      }}
      return solutions;
    }
  }
  
  
  //Programma principale
  public static void main( int n ) {
    /*
    //Prima parte, sperimentazione della nuova versione della classe Board
    int m []= {1,2,3,4,5,6,7,8,9,10}; //Soluzioni:1,0,0,2,10,4,40,92,352,724
    for( int i=0; i<m.length; i++ ) {
      System.out.println( numberOfSolutions(m[i]) );
      System.out.println( listOfAllSolutions(m[i]) );
    }
    */
   
    //Seconda parte, integrazione grafica
    //numero intero compreso tra 1 e 15
    System.out.println( "Numero Soluzioni:"+numberOfSolutions( n ) );
    ChessboardView gui = new ChessboardView( n );
    SList<Board> ls = listOfAllSolutions( n );
    
    for( int i=0; i<numberOfSolutions(n); i++ ) {
      //visualizza la configurazione (disposizione di regine) codificata dalla stringa s attraverso coppie lettera-cifra separate da spazi bianchi
      gui.setQueens( ls.car().toString() );
      //aggiorno la lista togliendo l'elemento gia' visualizzato per passare al prossimo
      ls = ls.cdr();
    }
  }
  
}