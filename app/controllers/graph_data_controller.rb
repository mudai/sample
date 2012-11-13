class GraphDataController < ApplicationController

  class Graph
    def initialize
    end

    def to_json
      {chart: {renderTo: 'graph'}}
    end
  end

  def sample
    render :json => Graph.new.to_json
  end

end

