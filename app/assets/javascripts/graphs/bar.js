// Based on http://bl.ocks.org/900762 by John Firebaugh

$(document).ready(function(){
	
    // set width, height of graph & data

	var w = 900,
	    h = 300,
        x = d3.scale.ordinal().domain(d3.range(data.length)).rangeBands([0, w], .2),
        y = d3.scale.linear().domain([0, d3.max(data)]).range([0, h]),
        kde = science.stats.kde().sample(data);

    // construct the graph

	var vis = d3.select("#graphs")
        .append("div")
            .attr("class", "graph")
	        .append("svg:svg")
	            .attr("width", w)
	            .attr("height", h)

    // create the bars

	var bars = vis.selectAll("g.bar")
	    .data(data)
        .enter().append("svg:g")
	        .attr("class", "bar")
	        .attr("transform", function(d, i) {
                return "translate(" + x(i) + "," + (h - y(d)) + ")";
            });
	
    // format the bars

	bars.append("svg:rect")
        .attr("height", 0)
        .attr("y", function(d, i) { return y(d) })
        .on("mouseover", selected)
        .on("mouseout", deselected)
        .transition().delay(function(d, i) { return i*40 })
            .duration(750)
	        .attr("fill", "#3d71a1")
	        .attr("width", x.rangeBand())
            .attr("height", y)
            .attr("y", 0)

    /*bars.append("svg:rect")
        .attr("height", 0)
        .attr("y", function(d, i) { return y(d) })
        .on("mouseover", selected)
        .on("mouseout", deselected)
        .transition().delay(function(d, i) { return i*40 })
            .attr("height", y/2)
            .attr("y", 0)
            .attr("fill", "#333")
            .attr("width", x.rangeBand())*/

    function selected(d, i) {
        d3.select(this)
            .attr("fill", "#333")
    }

    function deselected(d, i) {
        d3.select(this) 
            .attr("fill", "#3d71a1")
    }

    var line = d3.svg.line()
        .x(function(d) { return x(d[0]); })
        .y(function(d) { return h - y(d[1]); });

    vis.selectAll("path")
        .data(d3.values(science.stats.bandwidth))
        .enter().append("svg:path")
            .attr("d", function(h) {
                return line(kde.bandwidth(h)(d3.range(30, 110, .1)));
            });

    // format the bar value text

	/*bars.append("svg:text")
	    .attr("x", x.rangeBand() / 2)
	    .attr("y", 0)
	    .attr("dx", ".35em")
	    .attr("dy", -10)
	    .attr("fill", "black")
	    .attr("text-anchor", "start")
	    .text(y.tickFormat(100));*/
	
});
