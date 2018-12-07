# Proj1 - Distributed Sum of Consecutive Squares

## Goal
The input provided (as command line to your program, e.g. my app) will be two numbers: N and k. The overall goal of your program is to find all k consecutive numbers starting at 1 and up to N, such that the sum of squares is itself a perfect square (square of an integer) using Elixir and the actor model to build a good solution to this problem that runs well on multi-core machines.

## Team members

* Prahlad Misra [UFID: 00489999]
* Saranya Vatti [UFID: 29842706]

## Instructions

* Project was developed and tested in windows 8; 4 core
* Unzip Prahlad_Saranya.zip 

```sh
> unzip prahlad_saranya.zip
> cd prahlad_saranya
> mix run proj1.exs 3 2
Worker size : 1
Number of child processes : 3
3
Time taken: 0
```

* Output format: The numbers are printed as and when the workers evaluate the sums and hence is in a random order.

## About

* `ConsecutiveSquares` module parses command line arguments
* Errors are thrown if the two arguments, n and k are not integers or when there are lesser than two arguments. If there are more than two arguments, first two are taken
* Based on the work unit size, `ConsecutiveSquares` spawns off multiple 'actors' that each verify if any set of k consecutive integer squares sum upto a perfect square
* As the child/actor/worker module calculates the solutions, it is printed into the standard output with `IO.puts`
* After the worker is done with its share of computations, it sends a message to the parent and dies
* The parent keeps track of the number of children that have ended and after ALL the children die, the parent dies as well. 
* CPU time (User+Sys) / Real Time: 2.49 (Tested for input: 1000000 4)
* CPU time (User+Sys) / Real Time: 2.63 (Tested for input: 1000000 24)

## Size of work unit

* Tried splitting into the maximum number of workers possible, that is, n. This gives a good performance but only upto a small n. Kept a random limit of 10000 by trial and error
* For small n, we split the tasks for workers to have 1 number each or 100 or 1000 based on n. Optimum solution chosen by "Time taken" for each problem.
* When n is greater than 10000, dividing up n so that we have a maximum of 10000 concurrent processes.

## Result and running time

```sh
mix run proj1.exs 1000000 4
Time taken: 0

mix run proj1.exs 1000000 409
Worker size : 10000
Number of child processes : 100
71752
Time taken: 6320128
```

## Largest problem solved

```sh
mix run proj1.exs 100000000 24
Worker size : 10000
Number of child processes : 10000
1
9
20
25
44
12981
30908
54032
84996
353585
76
3029784
35709
3500233
121
20425
197
304
353
540
856
1301
2053
3112
3597
5448
8576
841476
202289
5295700
2002557
1273121
12602701
534964
29991872
306060
19823373
128601
52422128
45863965
8329856
34648837
82457176
Time taken: 16591872
```

## Additional Results

```sh

mix run proj1.exs 3 2
Worker size : 1
Number of child processes : 3
3
Time taken: 0

mix run proj1.exs 40 24
Worker size : 1
Number of child processes : 40
1
9
20
25
Time taken: 0

mix run proj1.exs 564 24
Number of child processes : 564
1
9
20
25
44
76
121
197
304
353
540
Time taken: 0

mix run proj1.exs 100 49
Worker size : 1
Number of child processes : 100
25
Time taken: 0

Get-Date -Format HH:mm:ss.fff
15:27:00.594
mix run proj1.exs 10000 289
Worker size : 1
Number of child processes : 10000
20
140
199
287
433
724
1595
Time taken: 0

mix run proj1.exs 1000000 409
Worker size : 10000
Number of child processes : 100
71752
Time taken: 6447104

mix run proj1.exs 1000000 4
Time taken: 128000

mix run proj1.exs 100000000 23
Number of child processes : 10000
Worker size : 10000
7
17
881
1351
42787
98520967
2053401
65337
3135331
73118402
88249445
Time taken: 41232384

mix run proj1.exs 1000000 24
Number of child processes : 100
Worker size : 10000
1
9
20
25
44
76
121
197
304
353
540
856
1301
2053
3112
3597
5448
8576
20425
30908
12981
306060
84996
841476
353585
35709
202289
534964
128601
54032
Time taken: 512000


mix run proj1.exs 37451846 24

Number of child processes : 3746
Worker size : 10000
1
9
20
25
30908
12981
44
54032
84996
841476
35709
76
121
197
3500233
304
353
540
856
1301
2053
20425
3112
3597
5448
8576
353585
202289
2002557
1273121
12602701
19823373
29991872
534964
5295700
306060
128601
3029784
8329856
34648837
Time taken : 7392256
```
