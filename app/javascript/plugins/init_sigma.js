sigma.classes.graph.addMethod('neighbors', function(nodeId) {
  var k,
  neighbors = {},
  index = this.allNeighborsIndex[nodeId] || {};
  
  for (k in index)
  neighbors[k] = this.nodesIndex[k];
  
  return neighbors;
});


const initSigma = () => {
  const mapElement = document.getElementById('arguments-map');
  
  if(mapElement) {
    sigma.parsers.json('/api/v1/sigma_arguments', {
      container: 'arguments-map',
      settings: {
        defaultNodeColor: '#2E5FE8',
        drawLabels: false
      }
    },
    function(s) {
      // We first need to save the original colors of our
      // nodes and edges, like this:
      s.graph.nodes().forEach(function(n) {
        n.originalColor = n.color;
      });
      s.graph.edges().forEach(function(e) {
        e.originalColor = e.color;
      });
      
      // When a node is clicked, we check for each node
      // if it is a neighbor of the clicked one. If not,
      // we set its color as grey, and else, it takes its
      // original color.
      // We do the same for the edges, and we only keep
      // edges that have both extremities colored.
      s.bind('clickNode', function(e) {
        var nodeId = e.data.node.id,
        toKeep = s.graph.neighbors(nodeId);
        toKeep[nodeId] = e.data.node;
        
        s.graph.nodes().forEach(function(n) {
          if (toKeep[n.id])
          n.color = n.originalColor;
          else
          n.color = '#8ba6ee';
        });
        
        s.graph.edges().forEach(function(e) {
          if (toKeep[e.source] && toKeep[e.target])
          e.color = e.originalColor;
          else
          e.color = '#8ba6ee';
        });
        
        // Since the data has been modified, we need to
        // call the refresh method to make the colors
        // update effective.
        s.refresh();
      });
      
      // When the stage is clicked, we just color each
      // node and edge with its original color.
      s.bind('clickStage', function(e) {
        s.graph.nodes().forEach(function(n) {
          n.color = n.originalColor;
        });
        
        s.graph.edges().forEach(function(e) {
          e.color = e.originalColor;
        });
        
        // Same as in the previous event:
        s.refresh();
      });
      
      s.startForceAtlas2({worker: false, barnesHutOptimize: true, slowDown: 1000, iterationsPerRender: 10, adjustSizes: true});
      
      //Set time interval to allow layout algorithm to converge on a good state
      var t = 0;
      var interval = setInterval(function() {
        t += 1;
        if (t >= 5) {
          clearInterval(interval);
          s.stopForceAtlas2();
        }
      }, 100);
    }
    );  
  };
};

export { initSigma };