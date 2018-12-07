import java.util.*;
import java.lang.*;
public class Test
{
	public static void main(String[] args) {
        /*int n = 10000;
        int k = 289;
        int[] arr = {20, 140, 199, 287, 433, 724, 1595};*/
        int n = 40;
        int k = 24;
        int[] arr = {5};
        for(int i=0;i<arr.length;i++) {
            int sum = 0;
            for(int j=arr[i];j<arr[i]+k;j++) {
                sum += j*j;
            }
            int r = (int)Math.sqrt(sum);
            if(r*r != sum) System.out.println(arr[i] + " is not the ans");
            else System.out.println(arr[i] + " is fine");
        }
	}
}
