package cs2321;

/**
 * This is the solution to the Fractional Knapsack problem, that utilizes a Heap, as an Adaptable Priority Queue
 * Course: CS2321 Section A01
 * Assignment: #4
 * @author Kyle Jarvis
 * Date: 10/25/22
 */

public class FractionalKnapsack {

   
	/**
	 * Goal: Choose items with maximum total benefit but with weight at most W.
	 *       You are allowed to take fractional amounts from items.
	 *       
	 * @param items items[i][0] is weight for item i
	 *              items[i][1] is benefit for item i
	 * @param knapsackWeight
	 * @return The maximum total benefit. Please use double type operation. For example 5/2 = 2.5
	 * 		 
	 */
	public static double MaximumValue(int[][] items, int knapsackWeight) {
		HeapAPQ<Double,Integer> pq = new HeapAPQ();

		if(knapsackWeight == 0){
			return 0;
		}

		for(int i = 0; i < items.length; i++){
			pq.insert(items[i][1]/(items[i][0] * -1.), items[i][0]);
		}

		int totalWeight = 0;
		double totalBenefit = 0;
		int take;

		while(totalWeight < knapsackWeight && pq.size() > 0){

			double unit = pq.min().getKey() * -1;
			int weight = pq.removeMin().getValue();

			if(weight <= knapsackWeight - totalWeight){
				take = weight;
			}
			else{
				take = knapsackWeight - totalWeight;
			}

			totalWeight = totalWeight + take;
			totalBenefit = totalBenefit + take * unit;
		}

		return totalBenefit;
	}
}
