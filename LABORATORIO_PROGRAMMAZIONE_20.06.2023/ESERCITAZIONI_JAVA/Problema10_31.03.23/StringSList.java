/**
 * UniUd - Programmazione e laboratorio - 2022-23
 * 154255 - Tavano Matteo
 * Esercitazione 2 in Java
 */

public class StringSList {            //Scheme-Like List of string
  
  // --- Costante lista vuta (condivisa) ---
  
    public static final StringSList NULL_STRINGLIST = new StringSList();
  
  // --- Rappresentazione interna di un lista: private! ---
  
    // Oggetti immutabili: variabili di istanza "final"
  
    private final boolean isEmpty;
    private final String first;
    private final StringSList rest;
  
  // --- Operazioni di base sulle liste, mutuate da Scheme ---
    
    // Costruttore: creazione di una lista vuota
    
    public StringSList() {
        
        isEmpty = true;
        first = "";
        rest  = null;       // null -> non c'è un oggetto
    }
    
    // Costruttore: creazione di una lista non vuota
    
    public StringSList( String e, StringSList sl ) {
        
        isEmpty = false;
        first = e;
        rest  = sl;
    }
    
    // Metodo per verificare se una lista è vuota
    
    public boolean isNull() {
        
        return isEmpty;
    }
    
    // Metodo per acquisire il primo elemento di una lista non vuota (car)
    
    public String car() {
        
        return first;
    }
    
    // Metodo per acquisire il resto di una lista non vuota (cdr)
    
    public StringSList cdr() {
        
        return rest;
    }
    
    // Realizzare alternativa del 'cons'
    
    public StringSList cons( String e ) {
        
        return new StringSList(e,this); // this fa riferimento al destinatario
        // la nuova lista inizia con e, poi continua coi miei elementi
    }
    
  // --- Operazioni aggiuntive, definite in termini dei precedenti metodi ---
  
    public int length() {
        
        if ( isNull() ) {
            return 0;
        } else {
            return 1 + cdr().length();
        }
    }

    public String listRef( int k ) {
        
        if ( k == 0 ) {
            return car();
        } else {
            return cdr().listRef(k-1);
        }
    }

    public boolean equals( StringSList sl ) {
        
        if ( this.isNull() || sl.isNull() ) {
            return (isNull() && sl.isNull());
        } else if ( this.car() == sl.car() ) {
            return this.cdr().equals( sl.cdr() );
        } else {
            return false;
        }
    }

    public StringSList append( StringSList sl ) {  // string list
     
        if ( this.isNull() ) {
            return sl;
        } else {
            return ( this.cdr().append(sl) ).cons( this.car() );
        }
    }
    
    public StringSList reverse() {
        
        return reverseTR( NULL_STRINGLIST );
    }
    private StringSList reverseTR( StringSList sl) {  // tail recursion
        
        if( isNull() ) {
            return sl;
        } else {
            return cdr().reverseTR( sl.cons( car() ) );
        }
    }

    /* --- Rappresentazione testuale (String) di una lista
     * toString ha importanza in Java, ci presenta una 
     * rappresentazione minimale dell'oggetto in questione, se io chiedo
     * di stampare in console la stringa mi accorgo subito della sua
     * utilità
  
    public String toString() {         // ridefinizione del metodo generale
        if ( isEmpty ) {               // per la visualizzazione testuale
            return "()";
        } else if ( rest.isNull() ) {
            return "(" + first + ")";  // -> il + trasforma direttamente
        } else {                       //    nella stringa in base 10 in 
            String rep = "(" + first;  //    questo caso
            IntSList r = rest;
            while ( !r.isNull() ) {
                rep = rep + ", " + r.car();
                r = r.cdr();
            }
            return ( rep + ")" );
        }
    }

    */
 
    public String toString() {         // ridefinizione del metodo generale
        
        if ( isNull() ) {              // per la visualizzazione testuale
            return "()";
        } else if (cdr().isNull() ) {
            return "(" + car() + ")";  // -> il + trasforma direttamente
        } else {                       //    nella stringa in base 10 in 
            String rep = "(" + car();  //    questo caso
            StringSList r = cdr();
            while ( !r.isNull() ) {
                rep = rep + ", " + r.car();
                r = r.cdr();
            }
            return ( rep + ")" );
        }
    }
    
    
}   // class StringSList
