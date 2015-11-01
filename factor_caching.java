package avant;

import java.util.Arrays;

public class factor_caching {
/* Given an array of [10, 5, 2, 20], the output would be:

{10: [5, 2], 5: [], 2: [], 20: [10,5,2]}*/
	public static String factor(int[] array) {
		int n=array.length;
		Arrays.sort(array);
		boolean[][] directedGraph=new boolean[n][n];
		//graph[i][j]==true indicates that j is a factor of i, else ==false
		for(int i=0;i<n;i++) Arrays.fill(directedGraph[i], false);
		for(int i=1;i<n;i++) {
			for(int j=i-1;j>=0;j--) {
				if(array[i]%array[j]==0) {
					directedGraph[i][j]=true;
				}
			}
		}
		StringBuilder sb=new StringBuilder();
		for(int i=0;i<n;i++) {
			sb.append(array[i]);
			sb.append(':');
			sb.append('[');
			for(int j=0;j<i;j++) {
				if(directedGraph[i][j]==true) {
					sb.append(array[j]);
					sb.append(',');
				}
			}
			if(sb.charAt(sb.length()-1)==',') sb.deleteCharAt(sb.length()-1);
			sb.append(']');
			sb.append(',');
		}
		sb.deleteCharAt(sb.length()-1);
		return sb.toString();	
	}
	public static void main(String[] args) {
		int[] test={5,10,2,20};
		System.out.println(factor(test));// TODO Auto-generated method stub

	}

}
