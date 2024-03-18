/**
 * This is the implementation of the Array List data structure
 * @auth Kyle Jarvis
 * CS2321, Fall 2020, R01
 * 9/28/22
 */

package cs2321;
import java.util.Iterator;

import net.datastructures.Position;
import net.datastructures.PositionalList;


public class DoublyLinkedList<E> implements PositionalList<E> {

	/**
	 * This is the implementation of the Node class to use the Doubly Linked List,
	 * Has multiple helper methods to make accessing and setting elements easier
	 * @param <E>
	 */
	public static class Node<E> implements Position<E> {

		private E element;
		private Node<E> prev;
		private Node<E> next;

		public Node(E e, Node<E> p, Node<E> n){
			element = e;
			prev = p;
			next = n;
		}

		@Override
		public E getElement() {
			return element;
		}

		public Node<E> getPrev(){
			return prev;
		}

		public Node<E> getNext() {
			return next;
		}

		public void setElement(E e) {
			element = e;
		}

		public void setPrevious(Node<E> p) {
			prev = p;
		}

		public void setNext(Node<E> n) {
			next = n;
		}
	}


	/**
	 * This is the Element iterator that will return one element at a time
	 */
	private class ElementIterator implements Iterator<E> {

		Iterator<Position<E>> posIterator = new PositionIterator();
		
		@Override
		public boolean hasNext() {
			return posIterator.hasNext();
		}

		@Override
		public E next() {
			return posIterator.next().getElement();
		}


		public void remove(){posIterator.remove();}
		
	}

	/**
	 * This is the Position iterator that will return one Position at a time
	 */
	private class PositionIterator implements Iterator<Position<E>> {

		private Position<E> cursor = first();
		private Position<E> recent = null;

		@Override
		public boolean hasNext() {
			// TODO Auto-generated method stub
			return cursor != null;
		}

		@Override
		public Position<E> next() {
			// TODO Auto-generated method stub
			if(cursor == null){
				throw new IllegalArgumentException();
			}
			recent = cursor;
			cursor = after(cursor);
			return recent;
		}
		
	}

	/**
	 * This is the Position iterator that will return one Position at a time
	 */
	private class PositionIterable implements Iterable<Position<E>> {

		@Override
		public Iterator<Position<E>> iterator() {
			// TODO Auto-generated constructor stub
			return new PositionIterator();
		}
		
	}

	/**
	 * This is an implementation of a Convert method, which takes a position and returns a node
	 * @param e
	 * @return
	 * @throws IllegalArgumentException
	 */
	public Node<E> convert (Position<E> e) throws IllegalArgumentException{
		if(!(e instanceof Node)){
			throw new IllegalArgumentException();
		}
		Node<E> node = (Node<E>) e;
		if(node.getNext() == null){
			throw new IllegalArgumentException();
		}
		return node;
	}

	/**
	 * These are the global variables for the Node class
	 */
	private Node<E> head;
	private Node<E> tail;
	private int size = 0;

	/**
	 * This is the constructor for the Doubly Linked List class
	 */
	public DoublyLinkedList() {
		head = new Node<>(null, null, null);
		tail = new Node<>(null, head, null);
		head.setNext(tail);
	}

	@Override
	public int size() {
		return size;
	}

	@Override
	public boolean isEmpty() {
		return size == 0;
	}

	@Override
	public Position<E> first() {
		return position(head.getNext());
	}

	@Override
	public Position<E> last() {
		return position(tail.getPrev());
	}

	/**
	 * This is another helper method that returns the node at the specified position
	 * @param node
	 * @return
	 */
	private Position<E> position(Node<E> node){
		if(node == head || node == tail){
			return null;
		}
		return node;
	}


	@Override
	public Position<E> before(Position<E> p) throws IllegalArgumentException {
		if(size == 0){
			throw new IllegalArgumentException();
		}
		Node<E> node = convert(p);
		return position(node.getPrev());
	}

	@Override
	public Position<E> after(Position<E> p) throws IllegalArgumentException {
		if(size == 0){
			throw new IllegalArgumentException();
		}
		Node<E> node = convert(p);
		return position(node.getNext());
	}

	/**
	 * This is another helper method used in other add/remove methods to add between certain elements
	 * @param e
	 * @param pred
	 * @param succ
	 * @return
	 */
	public Position<E> addBetween(E e, Node<E> pred, Node<E> succ){
		Node<E> newest = new Node<>(e,pred,succ);
		pred.setNext(newest);
		succ.setPrevious(newest);
		size++;
		return newest;
	}

	@Override
	public Position<E> addFirst(E e) {
		return addBetween(e, head, head.getNext());
	}

	@Override
	public Position<E> addLast(E e) {
		return addBetween(e, tail.getPrev(), tail);
	}

	@Override
	public Position<E> addBefore(Position<E> p, E e) throws IllegalArgumentException {
		if(size == 0){
			throw new IllegalArgumentException();
		}
		Node<E> holder = convert(p);
		return addBetween(e, holder.getPrev(), holder);
	}

	@Override
	public Position<E> addAfter(Position<E> p, E e) throws IllegalArgumentException {
		if(size == 0){
			throw new IllegalArgumentException();
		}
		Node<E> holder = convert(p);
		return addBetween(e, holder, holder.getNext());
	}

	@Override
	public E set(Position<E> p, E e) throws IllegalArgumentException {
		Node<E> holder = convert(p);
		E answer = holder.getElement();
		holder.setElement(e);
		return answer;
	}

	@Override
	public E remove(Position<E> p) throws IllegalArgumentException {
		if(size() == 0){
			throw new IllegalArgumentException();
		}

		Node<E> node = convert(p);
		Node<E> previous = node.getPrev();
		Node<E> next = node.getNext();
		previous.setNext(next);
		next.setPrevious(previous);
		size--;
		E answer = node.getElement();
		node.setNext(null);
		node.setPrevious(null);
		return answer;
	}

	/**
	 * This is the remove first method which removes the first node in the doubly linked list
	 * @return
	 * @throws IllegalArgumentException
	 */
	public E removeFirst() throws IllegalArgumentException {
		if(size() == 0){
			throw new IllegalArgumentException();
		}
		return remove(head.getNext());
	}

	/**
	 * This is the remove last method which removes the last node in the doubly linked list
	 * @return
	 * @throws IllegalArgumentException
	 */
	public E removeLast() throws IllegalArgumentException {
		if(size() == 0){
			throw new IllegalArgumentException();
		}
		return remove(tail.prev);
	}
	
	@Override
	public Iterator<E> iterator() {
		return new ElementIterator();
	}

	@Override
	public Iterable<Position<E>> positions() {
		return new PositionIterable();
	}

	@Override
	public Object [] toArray() {
		Object[] doublyLinkedList = new Object[size()];
		int index = 0;

		for (Position<E> element: positions()) {
			doublyLinkedList[index] = element.getElement();
			index++;
		}

		return doublyLinkedList;
	}


}
