package cs2321;

import java.util.Comparator;

import net.datastructures.*;
/**
 * A Adaptable PriorityQueue based on an heap. 
 * 
 * Course: CS2321 Section ALL
 * Assignment: #3
 * @author Kyle Jarvis
 */

public class HeapAPQ<K,V> implements AdaptablePriorityQueue<K,V> {
	/**
	 * These are the global variables needed to complete the Heap APQ
	 */
	public Comparator<K> comp;
	private ArrayList<Entry<K,V>> data;
	private int capacity;


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

	/**
	 * This is the class that establishes the getters and setters for our Heap APQ
	 * @param <K>
	 * @param <V>
	 */
	private static class apqEntry<K,V> implements Entry<K,V> {

		private int index;
		private K k;
		private V v;

		public apqEntry(K key, V value, int i){
			index = i;
			k = key;
			v = value;
		}

		@Override
		public K getKey() {
			return k;
		}

		public void setKey(K key){
			k = key;
		}

		@Override
		public V getValue() {
			return v;
		}

		public void setValue(V value){
			v = value;
		}

		public int getIndex(){
			return index;
		}

		public void setIndex(int j) {
			index = j;
		}


		
	}
	
	/* If no comparator is provided, use the default comparator. 
	 * See the inner class DefaultComparator above. 
	 * If no initial capacity is specified, use the default initial capacity.
	 */
	public HeapAPQ() {
		this(new DefaultComparator<K>(), ArrayList.INITIAL_CAPACITY);
	}
	
	/* Start the PQ with specified initial capacity */
	public HeapAPQ(int capacity) {
		this(new DefaultComparator(), capacity);
	}
	
	
	/* Use specified comparator */
	public HeapAPQ(Comparator<K> c) {
		this(c, ArrayList.INITIAL_CAPACITY);
	}
	
	/* Use specified comparator and the specified initial capacity */
	public HeapAPQ(Comparator<K> c, int capacity) {
		this.capacity = capacity;
		comp = c;
		data = new ArrayList<>(capacity);
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
		Object[] arrData = new Object[size()];
		for(int i = 0; i < size(); i++){
			Object holder = data.get(i);
			arrData[i] = holder;
		}
		return arrData;
	}

	/**
	 * This is the helper method parent, that determines the parent of the index j
	 * @param j
	 * @return
	 */
	private int parent(int j){
		return (j-1) / 2;
	}

	/**
	 * This is the helper method left, that determines the left child of the index j
	 * @param j
	 * @return
	 */
	private int left(int j){
		return 2 * j + 1;
	}


	/**
	 * This is the helper method right, that determines the right child of the index j
	 * @param j
	 * @return
	 */
	private int right(int j){
		return 2*j + 2;
	}

	/**
	 * This is the hasLeft method that determines if an index has a left child or not
	 * @param j
	 * @return
	 */
	private boolean hasLeft(int j){
		return left(j) < data.size();
	}
	/**
	 * This is the hasRight method that determines if an index has a right child or not
	 * @param j
	 * @return
	 */
	private boolean hasRight(int j){
		return right(j) < data.size();
	}

	/**
	 * This is the validate helper method, that views an entry to ensure that it is location aware
	 * @param entry
	 * @return
	 * @throws IllegalArgumentException
	 */
	private apqEntry<K,V> validate(Entry<K,V> entry) throws IllegalArgumentException {
		if(!(entry instanceof apqEntry)){
			throw new IllegalArgumentException("Invalid Entry");
		}

		apqEntry<K,V> locator = (apqEntry<K, V>) entry;
		int j = locator.getIndex();

		if(j>= data.size() || data.get(j) != locator){
			throw new IllegalArgumentException("Invalid Entry");
		}

		return locator;
	}

	/**
	 * This is the checkKey helper method, that checks if the given key is valid or not
	 * @param key
	 * @return
	 * @throws IllegalArgumentException
	 */
	private boolean checkKey(K key) throws IllegalArgumentException {
		try {
			return (comp.compare(key,key) == 0);
		}
		catch(ClassCastException e){
			throw new IllegalArgumentException("Incompatible Key");
		}
	}

	/**
	 * This is the bubble helper method, which determines weather we should use upheap, or downheap
	 * @param j
	 */
	private void bubble(int j){
		if(j > 0 && comp.compare(data.get(j).getKey(), data.get(parent(j)).getKey()) < 0){
			upheap(j);
		}
		else{
			downheap(j);
		}
	}

	/**
	 * This is the helper method swap, which swaps the pointer from two entries in the array
	 * @param i
	 * @param j
	 */
	private void swap(int i, int j){
		Entry<K,V> temp = data.get(i);
		data.set(i,data.get(j));
		data.set(j, temp);

		((apqEntry<K,V>) data.get(i)).setIndex(i);
		((apqEntry<K,V>) data.get(j)).setIndex(j);
	}

	/**
	 * This is the helper method upheap, sorts the tree if the swapped node needs to traverse up the tree
	 * @param j
	 */
	private void upheap(int j){
		if(j == 0){
			return;
		}
		if(comp.compare(data.get(j).getKey(), data.get(parent(j)).getKey()) > 0){
			return;
		}
		swap(j, parent(j));
		upheap(parent(j));
	}

	/**
	 * This is the helper method downheap, which is used when the swapped node needs to traverse down the tree
	 * @param j
	 */
	private void downheap(int j){
		while(hasLeft(j)){
			int leftIndex = left(j);
			int smallChildIndex = leftIndex;
			if(hasRight(j)) {
				int rightIndex = right(j);
				if (comp.compare(data.get(leftIndex).getKey(), data.get(rightIndex).getKey()) > 0) {
					smallChildIndex = rightIndex;
				}
			}
				if(comp.compare(data.get(smallChildIndex).getKey(), data.get(j).getKey()) >= 0)
					break;
				swap(j, smallChildIndex);
				j = smallChildIndex;
			}
		}



	@Override
	public int size() {
		return data.size();
	}

	@Override
	public boolean isEmpty() {
		return size() == 0;
	}

	/**
	 *
	 * @param key     the key of the new entry
	 * @param value   the associated value of the new entry
	 * @return
	 * @throws IllegalArgumentException
	 *
	 */
	@Override
	//@TimeComplexity("O(lg n)")
	//@TimeComplexityAmortized("O(1)")
	public Entry<K, V> insert(K key, V value) throws IllegalArgumentException {
		/**
		 * TCJ for Time Complexity
		 * The worst case is log(n), because all the other methods excemt upheap, is O(1), and
		 * upheap is O(lg n), because it takes lg n times to traverse the tree
		 *
		 * TCJ for Time Complexity Amortized
		 * The worst case for the Amortized cost, is O(1) because in the event that your array
		 * is at its max capacity, it needs to be copied to a new array - but typically it would be
		 * O(1), because just adding to the array doesn't require you to loop through anything
		 */
		checkKey(key);
		Entry<K,V> newest = new apqEntry<>(key,value, data.size());
		data.addLast(newest);
		upheap(data.size() - 1);
		return newest;
	}

	@Override
	//@TimeComplexity("O(1)")
	public Entry<K, V> min() {
		/**
		 * TCJ
		 * The worst case, is O(1) because the only things that are being ran, is a boolean value, and a
		 * simple get function. There are no loops, or while loops - or anything being traversed
		 */
		if(data.isEmpty()){
			return null;
		}
		return data.get(0);
	}

	@Override
	//@TimeComplexity("O(lg n)")
	public Entry<K, V> removeMin() {
		/**
		 * TCJ
		 * The worst case is log(n), because all the other methods except downheap, is O(1), and
		 * downheap is O(lg n), because it takes lg n times to traverse the tree
		 */
		Entry<K,V> e = data.get(0);

		if(data.isEmpty()){
			return null;
		}
		if(data.size() == 1){
			data.remove(0);
			return e;
		}

		swap(0, data.size() - 1);
		data.remove(data.size() - 1);
		downheap(0);
		return e;
	}

	@Override
	//@TimeComplexity("O(lg n)")
	public void remove(Entry<K, V> entry) throws IllegalArgumentException {
		/**
		 * TCJ
		 * The worst case is log(n), because all the other methods except bubble, is O(1), and
		 * bubble is O(lg n), because it takes lg n times to traverse the tree - regardless if
		 * you are using upheap or downheap
		 */
		apqEntry<K,V> locator = validate(entry);
		int j = locator.getIndex();
		if(j == data.size() - 1){
			data.remove(data.size() - 1);
		}
		else{
			swap(j, data.size() - 1);
			data.remove(data.size() - 1);
			bubble(j);
		}
		
	}

	@Override
	//@TimeComplexity("O(lg n)")
	public void replaceKey(Entry<K, V> entry, K key) throws IllegalArgumentException {
		/**
		 * TCJ
		 * The worst case is log(n), because all the other methods except bubble, is O(1), and
		 * bubble is O(lg n), because it takes lg n times to traverse the tree - regardless if
		 * you are using upheap or downheap
		 */
		apqEntry<K,V> locator = validate(entry);
		checkKey(key);
		locator.setKey(key);
		bubble(locator.getIndex());
		
	}

	@Override
	//@TimeComplexity("O(1)")
	public void replaceValue(Entry<K, V> entry, V value) throws IllegalArgumentException {
		/**
		 * TCJ
		 * The worst case, is O(1) because the only things that are being ran, is a boolean value, and a
		 * simple get function. There are no loops, or while loops - or anything being traversed
		 */
		apqEntry<K,V> locator = validate(entry);
		locator.setValue(value);
	}
	
	


}
