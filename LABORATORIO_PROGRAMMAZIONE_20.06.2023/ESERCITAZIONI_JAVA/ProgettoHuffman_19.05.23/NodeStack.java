/**
 * UniUd - Programmazione e laboratorio - 2022-23
 * 154255 - Tavano Matteo
 * Esercitazione 9 in Java
 */

import huffman_toolkit.*;

public class NodeStack{
    private Node[] array;
    private int size;
    
    public NodeStack(){
        size = 0;
        array = new Node[InputTextFile.CHARS];
    }

    public boolean empty(){
        return size == 0;
    }
    
    public Node peek() {
        return array[size-1];
    }
    
    public Node pop() {
        Node temp = array[size-1];
        array[size-1] = null;
        size--;
        return temp;
    }
    
    public void push(Node n) {
        array[size] = n;
        size++;
    }
}
