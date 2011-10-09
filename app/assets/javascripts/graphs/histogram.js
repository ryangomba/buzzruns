// Based on http://bl.ocks.org/900762 by John Firebaugh

$(document).ready(function() {
	
	var w = 900,
	    h = 400;
	
	var histogram = d3.layout.histogram()(data);
	
	var x = d3.scale.ordinal()
	    .domain(histogram.map(function(d) { return d.x; }))
	    .rangeRoundBands([0, w]);
	
	var y = d3.scale.linear()
	    .domain([0, d3.max(histogram, function(d) { return d.y; })])
	    .range([0, h]);
	
	var vis = d3.select("#graphs")
        .append("div")
            .attr("class", "graph")
            .append("svg:svg")
	            .attr("width", w)
	            .attr("height", h)
	  	        .append("svg:g")
	                .attr("transform", "translate(.5)");
	
	vis.selectAll("rect")
	    .data(histogram)
	  	.enter().append("svg:rect")
	    .attr("transform", function(d) { return "translate(" + x(d.x) + "," + (h - y(d.y)) + ")"; })
	    .attr("width", x.rangeBand())
	    .attr("y", function(d) { return y(d.y); })
	    .attr("height", 0)
	  	.transition()
	    .duration(750)
	    .attr("y", 0)
	    .attr("height", function(d) { return y(d.y); });
	
});
