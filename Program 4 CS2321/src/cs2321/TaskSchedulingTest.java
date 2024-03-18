package cs2321;

/**
 * These are the test cases to the Task Scheduling problem
 * Course: CS2321 Section A01
 * Assignment: #4
 * @author Kyle Jarvis
 * Date: 10/25/22
 */

import static org.junit.Assert.*;

import org.junit.Before;
import org.junit.Test;

public class TaskSchedulingTest {

	@Before
	public void setUp() throws Exception {
	}

	/**
	 * In this test, I used the example in the book to test if my code
	 * was actually working or not
	 */
	@Test
	public void testNumOfMachines1() {
		int[][] array = new int [][]{{3,7}, {1,4}, {1,3}, {2,5}, {4,7}, {6,9}, {7,8}, {1,3}};
		assertEquals(4, (TaskScheduling.NumOfMachines(array)));
	}

	/**
	 * In this test, I only tested for one possible machine to see if
	 * there were any discrepancies in my code
	 */
	@Test
	public void testNumOfMachines2(){
		int[][] array = new int [][]{{3,7}};
		assertEquals(1, (TaskScheduling.NumOfMachines(array)));
	}

	/**
	 * In this test, I tested an empty array, and expected the number
	 * of machines needed to be 0
	 */
	@Test
	public void testNumOfMachines3(){
		int[][] array = new int [][]{};
		assertEquals(0, (TaskScheduling.NumOfMachines(array)));
	}

}
