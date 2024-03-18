/**
 * This is the implementation of the Array List data structure
 * @auth Kyle Jarvis
 * CS2321, Fall 2020, R01
 * 9/28/22
 */

package cs2321;


import java.util.Iterator;

import net.datastructures.List;

public class ArrayList<E> implements List<E> {

	//these are the global variables needed to implement the class correctly
	private E[] data;
	private static final int INITIAL_CAPACITY = 16;
	private int currentSize = 0;
	private int capacity;

	/**
	 * This is the ArrayListIterator that is used for the test cases within the test classes
	 * Throws an IllegalArgumentException if there is no next value
	 */
	private class ArrayListIterator implements Iterator<E> {
		private int j = 0;

		@Override
		public boolean hasNext() {
			return j < currentSize;
		}

		@Override
		public E next() {
			if(hasNext()){
				return data[j++];
			}
			throw new IllegalArgumentException();
		}

	}

	/**
	 * This is the first constructor for the ArrayList class
	 * @param capacity
	 */
	public ArrayList(int capacity) {

		this.capacity = capacity;

		data = (E[]) new Object[capacity];
	}

	/**
	 * This is the second constructor for the ArrayList class
	 */
	public ArrayList() {

		this(INITIAL_CAPACITY);
	}

	/**
	 * This is the method that returns the size of the array
	 * @return
	 */
	@Override
	public int size() {

		return currentSize;
	}

	/**
	 * Returns the current capacity of array, not the number of elements.
	 * @return
	 */
	public int capacity() {
		return capacity;
	}

	/**
	 * Checks to see if the array has no elements inside
	 * @return
	 */
	@Override
	public boolean isEmpty() {
		return currentSize == 0;
	}

	/**
	 * This method gets an element from index i
	 * @param  i   the index of the element to return
	 * @return
	 * @throws IndexOutOfBoundsException
	 */
	@Override
	public E get(int i) throws IndexOutOfBoundsException {
		if(i > capacity()){
			throw new IndexOutOfBoundsException();
		}
		return data[i];
	}

	/**
	 * This method sets a new value to the given index, and returns that value at that index
	 * @param  i   the index of the element to replace
	 * @param  e   the new element to be stored
	 * @return
	 * @throws IndexOutOfBoundsException
	 */
	@Override
	public E set(int i, E e) throws IndexOutOfBoundsException {
		E tempData;
		if(i > currentSize){
			throw new IndexOutOfBoundsException();
		}
		else{
			tempData = data[i];
			data[i] = e;
		}
		return tempData;
	}

	/**
	 * This method adds an element in a given spot
	 * @param  i   the index at which the new element should be stored
	 * @param  e   the new element to be stored
	 * @throws IndexOutOfBoundsException
	 */
	@Override
	public void add(int i, E e) throws IndexOutOfBoundsException {
		if(i > size()){
			throw new IndexOutOfBoundsException();
		}

		if(size() == data.length){
			capacity *= 2;
			E[] dataCopy = (E[]) new Object [capacity];

			for(int k = 0; k < data.length; k++){
				dataCopy[k] = data[k];
			}
			data = dataCopy;
		}
		for(int l = currentSize - 1; l >= i; l--){
			data[l + 1] = data[l];
		}
		data[i] = e;
		currentSize++;
	}

	/**
	 * This method removes an element from a given spot
	 * @param  i   the index of the element to be removed
	 * @return
	 * @throws IndexOutOfBoundsException
	 */
	@Override
	public E remove(int i) throws IndexOutOfBoundsException {
		E temp;
		if(i > size() - 1){
			throw new IndexOutOfBoundsException();
		}
		else{
		temp = data[i];
			for(int k = i; k < size(); k++){
				data[k] = data[k + 1];
			}
		}
		data[size() - 1] = null;
		currentSize--;

		return temp;
	}

	/**
	 * This element adds an element to the beginning of the array
	 * @param e
	 */
	public void addFirst(E e)  {
		add(0, e);
	}

	/**
	 * This method adds an element to the end of the array
	 * @param e
	 */
	public void addLast(E e)  {
		add(size(), e);
	}

	/**
	 * This method removes the first element in the array
	 * @return
	 * @throws IndexOutOfBoundsException
	 */
	public E removeFirst() throws IndexOutOfBoundsException {
		if(size() == 0){
			throw new IndexOutOfBoundsException();
		}
		return remove(0);
	}

	/**
	 * This method removes the last element in the array
	 * @return
	 * @throws IndexOutOfBoundsException
	 */
	public E removeLast() throws IndexOutOfBoundsException {
		if(size() == 0){
			throw new IndexOutOfBoundsException();
		}
		return remove(size() - 1);
	}

	/**
	 * This is the iterator that is implemented to assist with test cases
	 * @return
	 */
	@Override
	public Iterator<E> iterator() {
		return new ArrayListIterator();
	}
}
