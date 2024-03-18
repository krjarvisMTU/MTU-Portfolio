package cs2321;

/**
 * These are the test cases to the Fractional Knapsack problem
 * Course: CS2321 Section A01
 * Assignment: #4
 * @author Kyle Jarvis
 * Date: 10/25/22
 */

import static org.junit.Assert.*;

import org.junit.Before;
import org.junit.Test;

public class FractionalKnapsackTest {

	@Before
	public void setUp() throws Exception {
	}

	/**
	 * In this test, I used the example in the book to test if my code
	 * was actually working or not
	 */
	@Test
	public void testMaximumValue1() {
		int[][] array = new int[][]{{4,12},{8,32}, {2,40},{6,30},{1,50}};
		assertEquals(124,(FractionalKnapsack.MaximumValue(array,10)),0.0001);
	}

	/**
	 * In this test, I created my own problem, to make sure that
	 * the books problem was not the only problem that was working
	 */
	@Test
	public void testMaximumValue2(){
		int[][] array = new int [][]{{4,4}, {6,30}};
		assertEquals(34,(FractionalKnapsack.MaximumValue(array,10)), 0.0001);
	}

	/**
	 * In this test, I tested an array with only zero values, and
	 * expected the return value to be zero, because there is no weight or benefit
	 */
	@Test public void testMaximumValue3(){
		int[][] array = new int[][]{{0,0}};
		assertEquals(0,(FractionalKnapsack.MaximumValue(array,0)), 0.0001);
	}

}
