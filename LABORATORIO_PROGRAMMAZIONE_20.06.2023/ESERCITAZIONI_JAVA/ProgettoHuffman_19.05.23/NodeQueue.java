/**
 * UniUd - Programmazione e laboratorio - 2022-23
 * 154255 - Tavano Matteo
 * Esercitazione 9 in Java
 */

import huffman_toolkit.*;

public class NodeQueue{
    
    private Node[] queue;
    private int size;
    
    public NodeQueue(){
        size=0;
        queue = new Node[InputTextFile.CHARS];
    }
    
    public int size(){
        return size;
    }
    
    public Node peek(){
        
        if (queue[0] != null) {
            
            Node min = queue[0];
        
            for (int i = 1; i < size; i++) {
                if (queue[i].compareTo(min) == -1) { 
                    min = queue[i];
                }
            }
        
            return min;
        
        } else {
            return null;
        }
    }
    
    public Node poll() {
        if (queue[0] != null) {
        
            Node poll = queue[0];
            int i = 1, k = 0; 
        
            while (i < size) {
                if (queue[i].compareTo(poll) == -1) {
                    poll = queue[i];
                    k = i;
                }
                i++;
            }
        
            queue[k] = null;
            tidy(); 
            size--;
        
            return poll;
            
        } else {
            return null;
        }
    }
    
    private void tidy() {
        Node[] s = new Node[size];
        
        for (int i = 0, j = 0; i < size && j < s.length; i++) {
            if (queue[i] != null) {
                s[j] = queue[i];
                j++;
            }
        }
        
        queue = s;
    }
    
    public void add(Node n){
        size++;
        nodeArrInsert(n, this.queue);
    }
    
    private Node[] nodeArrInsert(Node n, Node[] array){
        for (int i = 0; i<size; i++){
            if (array[i] == null) { 
                array[i] = n;
            } else {
                if (n.weight() > array[i].weight()){ 
                    Node temp = array[i];
                    array[i] = n;
                    nodeArrInsert(temp, array); 
                    break;
                }
            }   
        }
        return array;
    }
    
}
