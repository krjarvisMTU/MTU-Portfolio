package cs2321;

/**
 * This is the solution to the Task Scheduling problem, that utilizes a Heap, as an Adaptable Priority Queue
 * Course: CS2321 Section A01
 * Assignment: #4
 * @author Kyle Jarvis
 * Date: 10/25/22
 */

public class TaskScheduling {
	/**
	 * Goal: Perform all the tasks using a minimum number of machines. 
	 * 
	 *       
	 * @param tasks tasks[i][0] is start time for task i
	 *              tasks[i][1] is end time for task i
	 * @return The minimum number or machines
	 */
   public static int NumOfMachines(int[][] tasks) {

	   if(tasks.length == 0){
		   return 0;
	   }

	   HeapAPQ<Integer, Integer> schedule = new HeapAPQ<>();
	   HeapAPQ<Integer, Integer> endTime = new HeapAPQ<>();

	   for(int i = 0; i < tasks.length; i++){
		   schedule.insert(tasks[i][0], tasks[i][1]);
	   }

	   int minS = schedule.min().getKey();
	   int maxS = schedule.removeMin().getValue();

	   endTime.insert(maxS, 0);

	   int maxE = endTime.min().getKey();

	   while(schedule.size() != 0){
		   minS = schedule.min().getKey();
		   maxS = schedule.removeMin().getValue();

		   if(minS >= maxE){
			   endTime.replaceKey(endTime.min(), maxS);
		   }
		   else if(minS < maxE){
			   endTime.insert(maxS, 0);
		   }
	   }

	   return endTime.size();
   }
}
