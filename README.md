# Dijkstra Trace

A simple Dijkstra algorithm implementation to find the shortest path between any two points in the undirected graph. 

## Installation

Install the gem by adding the following line in your Gemfile and run `bundle install`
```ruby
gem 'dijkstra_trace'
```
or simply run `bundle add dijkstra_trace`
## Usage

Create an object for `Dijkstra::Trace` class with the graph edges as its argument.
```ruby
require 'dijkstra_trace'

edges = [
    [0,1,55],
    [1,2,100],
    [0,3,75],
    [3,4,60],
    [1,4,75],
    [3,6,50],
    [4,7,50],
    [6,7,65],
    [2,5,95],
    [5,8,65],
    [7,8,40],
    [8,9,40],
    [9,10,40],
    [9,11,50],
    [10,12,75],
    [11,13,110],
    [12,13,50]
]


graph = Dijkstra::Trace.new(edges)
path = graph.path(2,13)

puts "The shortest distance between #{path.starting_point} and #{path.ending_point} is #{path.distance} units"
puts "The shortest path: #{path.path}"

```
### Output
```
The shortest distance between 2 and 13 is 360 units
The shortest path: [2, 5, 8, 9, 11, 13]
```

The Graph matrix and the adjacent matrix can also be viewed by calling the methods `graph_matrix` and `adjacent_matrix` on the `Dijkstra::Trace` class object.
```
irb(main):001:0> pp graph.graph_matrix

[[0, 55, 0, 75, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
 [55, 0, 100, 0, 75, 0, 0, 0, 0, 0, 0, 0, 0, 0],
 [0, 100, 0, 0, 0, 95, 0, 0, 0, 0, 0, 0, 0, 0],
 [75, 0, 0, 0, 60, 0, 50, 0, 0, 0, 0, 0, 0, 0],
 [0, 75, 0, 60, 0, 0, 0, 50, 0, 0, 0, 0, 0, 0],
 [0, 0, 95, 0, 0, 0, 0, 0, 65, 0, 0, 0, 0, 0],
 [0, 0, 0, 50, 0, 0, 0, 65, 0, 0, 0, 0, 0, 0],
 [0, 0, 0, 0, 50, 0, 65, 0, 40, 0, 0, 0, 0, 0],
 [0, 0, 0, 0, 0, 65, 0, 40, 0, 40, 0, 0, 0, 0],
 [0, 0, 0, 0, 0, 0, 0, 0, 40, 0, 40, 50, 0, 0],
 [0, 0, 0, 0, 0, 0, 0, 0, 0, 40, 0, 0, 75, 0],
 [0, 0, 0, 0, 0, 0, 0, 0, 0, 50, 0, 0, 0, 110],
 [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 75, 0, 0, 50],
 [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 110, 50, 0]]
```