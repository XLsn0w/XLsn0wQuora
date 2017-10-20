//
//  AlgorithmObject.m
//  XLsn0wQuora
//
//  Created by golong on 2017/10/20.
//  Copyright © 2017年 XLsn0w. All rights reserved.
//

#import "AlgorithmObject.h"

@implementation AlgorithmObject
/**
 冒泡排序
 1. 首先将所有待排序的数字放入工作列表中；
 2. 从列表的第一个数字到倒数第二个数字，逐个检查：若某一位上的数字大于他的下一位，则将它与它的下一位交换；
 3. 重复2号步骤(倒数的数字加1。例如：第一次到倒数第二个数字，第二次到倒数第三个数字，依此类推...)，直至再也不能交换。
 
 最好的时间复杂度为O(n)
 最坏的时间复杂度为O(n^2)
 平均时间复杂度为O(n^2)
 */
- (NSMutableArray *)bubbleSortWithArray:(NSArray *)array
{
    id temp;
    NSUInteger i, j;
    NSMutableArray *a = [NSMutableArray arrayWithArray:array];
    
    for (i = 0; i < a.count-1; i++) {
        for (j = 0; j < a.count-1-i; j++) {
            if (a[j] > a[j+1]) {        // 升序
                temp = a[j];
                a[j] = a[j+1];
                a[j+1] = temp;
            }
        }
    }
    
    NSLog(@"bubbleSort:%@", a);
    return a;
}

/**
 插入排序
 1.初始时，a[0]自成1个有序区，无序区为a[1..n-1]。令i=1
 2.将a[i]并入当前的有序区a[0…i-1]中形成a[0…i]的有序区间。
 3.i++并重复第二步直到i==n-1。排序完成。
 
 最好的时间复杂度为O(n)
 最坏的时间复杂度为O(n^2)
 平均时间复杂度为O(n^2)
 */
- (NSMutableArray *)insertSortWithArray:(NSArray *)array
{
    id temp;
    NSUInteger i, j;
    NSMutableArray *a = [NSMutableArray arrayWithArray:array];
    
    for (i = 1; i < a.count; i++) {
        temp = a[i];
        for (j = i; j>0 && a[j-1]>temp; j--) {
            a[j] = a[j-1];
        }
        a[j] = temp;
    }
    
    NSLog(@"insertSort:%@", a);
    return a;
}

/**
 选择排序
 1. 设数组内存放了n个待排数字，数组下标从0开始，到n-1结束；
 3. 从数组的第a[i+1]个元素开始到第n个元素，寻找最小的元素。（具体过程为:先设a[i]（i=0）为最小，逐一比较，若遇到比之小的则交换）；
 4. 将上一步找到的最小元素和a[i]元素交换；
 5. 如果i=n－1算法结束，否则回到第3步。
 
 最好的时间复杂度为O(n^2)
 最坏的时间复杂度为O(n^2)
 平均时间复杂度为O(n^2)
 */
- (NSMutableArray *)selectSortWithArray:(NSArray *)array
{
    id temp;
    NSUInteger min, i, j;
    NSMutableArray *a = [NSMutableArray arrayWithArray:array];
    
    for (i = 0; i < array.count; i++) {
        min = i;
        for (j = i+1; j < array.count; j++) {
            if (a[min] > array[j]) {
                min = j;
            }
        }
        if (min != i) {
            temp = a[min];
            a[min] = a[i];
            a[i] = temp;
        }
    }
    
    NSLog(@"insertSort:%@", a);
    return a;
}

/**
 快速排序
 1．先从数列中取出一个数作为基准数;
 2．分区过程，将比这个数大的数全放到它的右边，小于或等于它的数全放到它的左边;
 3．再对左右区间重复第二步，直到各区间只有一个数。
 
 最好的时间复杂度为O(nlog2n)
 最坏的时间复杂度为O(n^2)
 平均时间复杂度为O(nlog2n)
 */
- (void)quickSortWithArray:(NSMutableArray *)array
{
    [self quickSortWithArray:array left:0 right:array.count-1];
}

- (void)quickSortWithArray:(NSMutableArray *)a left:(NSUInteger)left right:(NSUInteger)right
{
    if (left >= right) {
        return;
    }
    NSUInteger i = left;
    NSUInteger j = right;
    id key = a[left];
    
    while (i < j) {
        while (i < j && key <= a[j]) {
            j--;
        }
        a[i] = a[j];
        
        while (i < j && key >= a[i]) {
            i++;
        }
        a[j] = a[i];
    }
    
    a[i] = key;
    [self quickSortWithArray:a left:left right:i-1];
    [self quickSortWithArray:a left:i+1 right:right];
}


#pragma mark - 二分查找法
/**
 *  当数据量很大适宜采用该方法。
 采用二分法查找时，数据需是排好序的。
 基本思想：假设数据是按升序排序的，对于给定值x，从序列的中间位置开始比较，如果当前位置值等于x，则查找成功；若x小于当前位置值，则在数列的前半段 中查找；若x大于当前位置值则在数列的后半段中继续查找，直到找到为止。
 */
- (NSInteger)BinarySearch:(NSArray *)array target:(id)key
{
    NSInteger left = 0;
    NSInteger right = [array count] - 1;
    NSInteger middle = [array count] / 2;
    
    while (right >= left) {
        middle = (right + left) / 2;
        
        if (array[middle] == key) {
            return middle;
        }
        if (array[middle] > key) {
            right = middle - 1;
        }
        else if (array[middle] < key) {
            left = middle + 1;
        }
    }
    return -1;
}

- (void)print:(NSArray *)array
{
    for (id m in array) {
        NSLog(@"%@", m);
    }
    NSLog(@"-----------------");
}

@end
