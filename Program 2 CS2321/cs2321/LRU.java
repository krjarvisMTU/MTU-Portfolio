/**
 * This is the implementation of the Array List data structure
 * @auth Kyle Jarvis
 * CS2321, Fall 2020, R01
 * 9/28/22
 */

package cs2321;

import net.datastructures.*;

/*
 * The design of this program is related to Cache replacement policy in OS 
 * https://en.wikipedia.org/wiki/Cache_replacement_policies#Least_recently_used_(LRU)
 * 
 * LRU: Discards the least recently used items first.
 * 
 * Let's say we have a online store and would like to keep a list of certain number of customers
 * who visited our site from the most recent to the least recent.  
 * 
 * For example: 
 * 
 *  Let's say K=4, which means we only keep the most recent 4 customers. 
 *  And the visiting sequence of the customers: A B C D E D F. Each letter represent a customer's name.
 *
 *  The recent list will change as customers coming:
 *   
 *   A          -- A is the first customer
 *   B A        -- B is not on the list and B's visit to use is sooner than A's
 *   C B A      -- C is not on the list and D's visit to use is sooner than B's
 *   D C B A    -- D is not on the list and D's visit to use is sooner than C's
 *   E D C B    -- E is not on the list. But The list is full. 
 *                 Kick out A as it is the least recent one. 
 *                 Add E to the most recent one. 
 *              
 *   D E C B    -- D is on the list already.  D's place is moved from second to the first. 
 *   
 *   F D E C    -- F is not on the list. The list is full.
 *                 Kick out B and put F as the most recent one 
 *   
 *  For simplicity we only keep the customer name in the list. 
 *  But to make the list useful, we will store some other information associated with the customer.  
 * 
 */


public class LRU {

	//These are my global variables needed to keep track and instantiate my doubly linked list
	public DoublyLinkedList<String> list;
	public int size;


	/* Keep up to K customers who visits us recently from the most recent to the least recent. */
	public LRU(int K) {
		size = K;
		list = new DoublyLinkedList<>();
	}
	
	/* customer visits us, one at a time */
	public void visit(String customer) {
		for (Position<String> p: list.positions()) {
			if (p.getElement().equals(customer)) {
				list.remove(p);
			}
		}
		if (list.size() == size){
			list.removeLast();
		}
		list.addFirst(customer);
	}

	
	/* return the most recent K customers */
	public PositionalList<String> getList() {
		//TODO: implement this  
		return list;
	}
		
	
}
