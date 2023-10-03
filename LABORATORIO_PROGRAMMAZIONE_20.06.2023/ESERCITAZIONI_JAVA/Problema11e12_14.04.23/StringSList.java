/**
 * UniUd - Programmazione e laboratorio - 2022-2023
 * 154255 - Tavano Matteo
 * Esercitazione 3-4 in Java
 */

public class StringSList {
    //elementi privati che compongono il nostro "tipo"
    private final boolean empty; //restituisce vero se la lista Ã¨ vuota            
    private final String first; //car                
    private final StringSList rest; //cdr
    
    
    public StringSList() { //creazione di una lista vuota
        empty = true;
        first = null;                            
        rest = null;
    }
    
    
    public StringSList( String e, StringSList il ) { //creazione di una lista non vuota
        empty = false;
        first = e;
        rest = il;
    }
    
    
    public StringSList( String e ) { //creazione di una lista con la possibilitÃ  di passare solo il first
        empty = false;
        first = e;
        rest = null;
    }

    
    public boolean isNull() {                                
        return ( empty );
    }
    
   
    public String car() {
        return first;                        
    }
    
    
    public StringSList cdr() {
        return rest;                           
    }
    
    
    public StringSList cons( String e ) { 
        return new StringSList( e, this );
    }
    
    
    public int length() {
        if ( isNull() ) { //se empty Ã¨ true
            return 0;
        } else {
            return ( 1 + cdr().length() ); //sommo 1 alla ric
        }
    }
    
    
    public String listRef( int k ) {
        if ( k == 0 ) { 
            return car();
        } else {
            return ( cdr().listRef(k-1) ); //ricorsione
        }
    }
    
    
    public boolean equals( StringSList il ) {
        if ( isNull() || il.isNull() ) { //se la lista corrente o quella in ingresso sono nulle
            return ( isNull() && il.isNull() ); //restituisce and tra i due valori booleani
        } else if ( car() == il.car() ) { //se il primo elemento di entrambe le liste coincide
            return cdr().equals( il.cdr() ); //ricorsione
        } else {
            return false; //le liste non sono uguali
        }
    }
    
    
    public StringSList append( StringSList il ) {
        if ( isNull() ) {
            return il;
        } else {
            return ( cdr().append(il) ).cons( car() ); //inserisco il primo elem della seconda lista alla ricorsione
        }
    }
    
    
    public StringSList reverse() {
        return reverseRec( new StringSList() );
    }
  
    
    private StringSList reverseRec( StringSList re ) {
        if ( isNull() ) {                     
            return re;
        } else {
            // return cdr().reverseRec( new IntSList(car(),re) );
            return cdr().reverseRec( re.cons(car()) ); //porta il primo elem nell'ultima posizione e unisce cdr e car
        }
    }

    
    public String toString() { 
        if ( empty ) {
            return "()";
        } else if ( rest.isNull() ) { //cdr Ã¨ nullo
            return "(" + first + ")"; //Ã¨ presente un solo elemento
        } else {
            String rep = "(" + first; //car
            StringSList r = rest; //cdr
            while ( !r.isNull() ) { //fintanto che r non Ã¨ vuoto
                rep = rep + ", " + r.car(); //acccodo il primo elemento di cdr nella stringa
                r = r.cdr(); //elimino l'elemento appena inserito
            }
            return ( rep + ")" ); //chiudo la parentesi e restituisco la stringa
        }
    }
       
}
