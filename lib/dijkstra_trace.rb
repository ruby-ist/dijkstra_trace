module Dijkstra

    # The resulting shortest path will be an object of the Path class
    class Path
        attr_accessor :starting_point, :ending_point, :distance, :path
        # Distance variable stores the total distance of the path
        # Path array has the vertices connecting the shortest path
        # Starting point, ending point are used to get the source and destination of the resulting path if needed

        def initialize(source, destination)
            @starting_point = source
            @ending_point = destination
            @distance = 0
            @path = []
        end
    end

    # Trace is the main class used to find the shortest path
    class Trace
        # the most maximum distance value can be set by changing the infinity variable
        # of the Trace after initialization

        attr_accessor :infinity
        # edges should be an two dimensional array, where each column should contain three elements
        # Example: [1,2,45], ['a','b',37]
        # edge vertices can be of any format, but the distance should be a numeric value

        def initialize(edges)
            @edges = edges
            @map = map_vertices
            @no_of_vertices = @map.count

            @infinity = 9999999
        end

        # map_vertices function maps the given vertices to the indices
        # starting from 0 to the number of vertices for better calculation
        def map_vertices
            result = {}
            vertices = (@edges.map { |i| i[0] } + @edges.map { |i| i[1] }).uniq.sort
            vertices.length.times do |i|
                result[vertices[i]] = i
            end
            result
        end

        # compact_min finds the minimum integer value in the array which includes nil values
        def compact_min(arr)
            min = @infinity
            arr.each do |i|
                if i != nil && i < min
                    min = i
                end
            end
            min
        end

        # adjacent_matrix method will produce the Adjacent matrix for the given edges
        # It can be called separately after initialization without calling path method
        def adjacent_matrix
            adjacent = Array.new(@no_of_vertices) { Array.new(@no_of_vertices) { false } }
            @edges.each do |edge|
                adjacent[@map[edge[0]]] [@map[edge[1]]] = true
                adjacent[@map[edge[1]]] [@map[edge[0]]] = true
            end
            adjacent
        end

        # graph_matrix method will produce the matrix representation of the graph the given edges
        # It also can be called separately after initialization without calling path method
        def graph_matrix
            graph = Array.new(@no_of_vertices) { Array.new(@no_of_vertices) { 0 } }
            @edges.each do |edge|
                graph[@map[edge[0]]] [@map[edge[1]]] = edge[2]
                graph[@map[edge[1]]] [@map[edge[0]]] = edge[2]
            end
            graph
        end

        # Path method is used to find the shortest path between two points (source, destination)
        def path(source, destination)
            # An Path object is initially created with given source and destination
            result = Path.new(source, destination)

            weight = Array.new(@no_of_vertices) { @infinity }
            parent = Array.new(@no_of_vertices)

            adjacent = adjacent_matrix
            graph = graph_matrix

            # the hash @map contains the index value used for calculation for the respective vertex
            source = @map[source]
            destination = @map[destination]

            chosen = source
            weight[source] = 0

            # Iteration of the Dijkstra Algorithm
            while chosen != destination do

                adjacent[chosen].each_with_index do |neighbor, i|
                    next if !neighbor || weight[i] == nil
                    new_weight = weight[chosen] + graph[chosen][i]
                    if new_weight < weight[i]
                        weight[i] = new_weight
                        parent[i] = chosen
                    end
                end

                weight[chosen] = nil
                chosen = weight.index compact_min(weight)
            end

            # the Path class object 'result' is updated with distance and actual path
            result.distance = weight[destination]
            current = destination

            # shortest path is found by backtracking the parent array after the completion of the Dijkstra algorithm
            while current != nil
                result.path.unshift @map.key(current)
                current = parent[current]
            end

            result
        end
    end
end
