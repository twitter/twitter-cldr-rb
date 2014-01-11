# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

module TwitterCldr
  module Transforms

    class Vertex
      attr_reader :value, :neighbors

      def initialize(value, neighbors = {})
        @value = value
        @neighbors = neighbors || {}
      end

      def add_neighbor(vertex)
        neighbors[vertex.value] ||= vertex
      end
    end

    class Graph
      attr_reader :vertices

      def initialize
        @vertices = {}
      end

      def add_vertex(value)
        vertices[value] ||= create_vertex(value)
      end

      def add_edge(value1, value2)
        vertices[value1].add_neighbor(vertices[value2])
      end

      # Djikstra's shortest path algorithm, adapted from:
      # https://gist.github.com/yaraki/1730288
      def shortest_path(source, target = nil)
        distances = {}
        previouses = {}

        vertices.each_pair do |key, vertex|
          distances[key] = nil # Infinity
          previouses[key] = nil
        end

        distances[source] = 0
        verts = vertices.clone        

        until verts.empty?
          nearest_vertex = verts.inject(verts.first.first) do |a, (b, c)|
            next b unless distances[a]
            next a unless distances[b]
            next a if distances[a] < distances[b]
            b
          end

          break unless distances[nearest_vertex] # Infinity

          if target && nearest_vertex == target
            return compose_path(target, distances[target], previouses)
          end

          neighbors = verts[nearest_vertex].neighbors
          neighbors.each_pair do |name, vertex|
            alt = distances[nearest_vertex] + 1

            if distances[name].nil? || alt < distances[name]
              distances[name] = alt
              previouses[name] = nearest_vertex
            end
          end
          verts.delete(nearest_vertex)
        end
      end

      private

      def compose_path(target, distance, previouses)
        result = Array.new(distance)
        distance.downto(0) do |i|
          result[i] = target
          target = previouses[target]
        end
        result
      end

      def create_vertex(value, edges = nil)
        Vertex.new(value, edges)
      end
    end

  end
end
