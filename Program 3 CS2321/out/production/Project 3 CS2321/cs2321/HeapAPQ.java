package cs2321;

import java.util.Comparator;

import net.datastructures.*;
/**
 * A Adaptable PriorityQueue based on an heap. 
 * 
 * Course: CS2321 Section ALL
 * Assignment: #3
 * @author
 */

public class HeapAPQ<K,V> implements AdaptablePriorityQueue<K,V> {
	
	public static class DefaultComparator<K> implements Comparator<K> {
		
		// This compare method simply calls the compareTo method of the argument. 
		// If the argument is not a Comparable object, and therefore there is no compareTo method,
		// it will throw ClassCastException. 
		public int compare(K a, K b) throws IllegalArgumentException {
			if (a instanceof Comparable ) {
			   return ((Comparable <K>) a).compareTo(b);
			} else {
				throw new  IllegalArgumentException();
			}
		}
	}
	
	private static class apqEntry<K,V> implements Entry<K,V> {

		@Override
		public K getKey() {
			// TODO Auto-generated method stub
			return null;
		}

		@Override
		public V getValue() {
			// TODO Auto-generated method stub
			return null;
		}
		
	}
	
	/* If no comparator is provided, use the default comparator. 
	 * See the inner class DefaultComparator above. 
	 * If no initial capacity is specified, use the default initial capacity.
	 */
	public HeapAPQ() {
		//TODO: implement this method 
	}
	
	/* Start the PQ with specified initial capacity */
	public HeapAPQ(int capacity) {
		//TODO: implement this method 
	}
	
	
	/* Use specified comparator */
	public HeapAPQ(Comparator<K> c) {
		//TODO: implement this method 
	}
	
	/* Use specified comparator and the specified initial capacity */
	public HeapAPQ(Comparator<K> c, int capacity) {
		//TODO: implement this method 
	}
	
	/* 
	 * The data in your heap should have been stored in ArrayList which uses array.
	 *  
	 * Make a new array, copy the data in the heap's ArrayList to the new array 
	 * in proper sequence (from first to last element) 
	 * 
	 * This method is purely for testing purpose of auto-grader
	 */
	public Object[] data() {
		//TODO: replace the line below to return the actual array in arraylist
		//TODO: You may want to add a method in your arrayList implementation 
		//TODO: to allow the access to the array. 
		
		return  null;
	}


	@Override
	public int size() {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public boolean isEmpty() {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public Entry<K, V> insert(K key, V value) throws IllegalArgumentException {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public Entry<K, V> min() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public Entry<K, V> removeMin() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public void remove(Entry<K, V> entry) throws IllegalArgumentException {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void replaceKey(Entry<K, V> entry, K key) throws IllegalArgumentException {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void replaceValue(Entry<K, V> entry, V value) throws IllegalArgumentException {
		// TODO Auto-generated method stub
		
	}
	
	


}
