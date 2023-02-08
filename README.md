# Random Visualisations
Some visualisations of algorithms and math made in processing / java

## Labrith creating algorithm

A simple [recursive backtracking algorithm using depth first search](https://en.wikipedia.org/wiki/Maze_generation_algorithm#Recursive_implementation) to genereate a maze.

![](lab_vis.gif)

## Rose

Still have to find the name of this thing. The idea is basicaly to have a circle of radius $r$ be bounded by $n$ tangents. The intersections of each tangent make a shape of $n$ vertices and $n$ edges. Each vertex lies on another circle, that is bound by $n+1$ tangents and so on. The radius $r_{n+1}$ is defined by $r_{n+1} = r_n \div \cos(\frac{\pi}{n})$.

Each shape rotates based on the number of vertices: if prime, it rotates clockwise, if even, it rotates counter-clockwise.

![](rose.gif)
