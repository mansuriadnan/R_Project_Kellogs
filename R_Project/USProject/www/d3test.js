// Set dimensions and margins for the chart

// const margin = { top: 70, right: 30, bottom: 40, left: 80 };
const margin = { top: 40, right: 24, bottom: 28, left: 24 };
const width = 571 - margin.left - margin.right;
const height = 307 - margin.top - margin.bottom;

// Set up the x and y scales
const x = d3.scaleTime()
	.range([0, width]);

const y = d3.scaleLinear()
	.range([height, 0]);

// Create the SVG element and append it to the chart container

const svg = d3.select("#chart-container")
	.append("svg")
	.attr("width", width + margin.left + margin.right)
	.attr("height", height + margin.top + margin.bottom)
	.append("g")
	.attr("transform", `translate(${margin.left},${margin.top})`);

// // Load and Process Data
//jayendra
d3.csv("jdi_data_daily.csv").then(function (data) {
	createChart(data)
})

function createChart(data) {
	console.log('jayendra')
	console.log(d3.max(data, (d) => d.population))

	//Create rectangle
	var rects = svg.append("g")
		.append("rect")
		.attr("class", 'rectangle')
		.attr("x", -(margin.left))
		.attr("y", -(margin.top))
		.attr("width", width + margin.left + margin.right)
		.attr("height", height + margin.top + margin.bottom)
		.attr("fill", "white")
		.attr("stroke", "#D5DBF0")
		.attr("stroke-width", "0.5")
		.attr("rx",5 );

	// plus sign
	svg.append("g")
		.append("rect")
		.attr("class", 'addData')
		.attr("x", width)
		.attr("y", -28)
		.attr("width", 16)
	    .attr("height", 16)
		.attr("fill", 'rgb(224, 224, 224)')
		
		svg.append("text")
		.style("font-size", "18px")
		.text("+")
		.attr("x", width + 3)
		.attr("y", -14)
		.attr("fill", "#9096AE")
		.style("font-weight", "bold");

	svg.append('line')
		.style("stroke", "#D5DBF0")
		.style("stroke-width", .5)
		.attr("x1", -(margin.left))
		.attr("y1", 0)
		.attr("x2", width + margin.right)
		.attr("y2", 0);

	svg.append('line')
		.style("stroke", "#D5DBF0")
		.style("stroke-width", .5)
		.attr("x1", -(margin.left))
		.attr("y1", height)
		.attr("x2", width + margin.right)
		.attr("y2", height);

	svg.append('line')
		.style("stroke", "#D5DBF0")
		.style("stroke-width", .5)
		.attr("x1", 0)
		.attr("y1", 0)
		.attr("x2", 0)
		.attr("y2", height);

	// Parse the date and convert the population to a number
	const parseDate = d3.timeParse("%Y-%m-%d");
	data.forEach(d => {
		d.date = parseDate(d.date);
		d.population = +d.population;
	});

	// Define the x and y domains

	var minPopulation = d3.min(data, d => d.population)

	x.domain(d3.extent(data, d => d.date));
	y.domain([minPopulation - 10, d3.max(data, d => d.population) + 10]);

	// Add the x-axis
	svg.append("g")
		.attr("transform", `translate(0,${height})`)
		.style("font-size", "14px")
		.call(d3.axisBottom(x)
			.tickValues(x.ticks(d3.timeMonth.every(2)))
			.tickFormat(d3.timeFormat("%b")))
		.call(g => g.select(".domain").remove())
		.selectAll(".tick line")
		.style("stroke-opacity", 0)
	svg.selectAll(".tick text")
		.attr("fill", "#000")
		.attr("font-weight", "600")
		.style("font-family", "Montserrat")
		.style("font-size", "12");

	// Add the y-axis
	svg.append("g")
		.style("font-size", "14px")
		.call(d3.axisLeft(y)
			.ticks((d3.max(data, d => d.population) - minPopulation) / 5000)
			.tickFormat(d => {
				return `${(d / 1000).toFixed(0)}k`;
			})
			.tickSize(0)
			.tickPadding(10))
		.call(g => g.select(".domain").remove())
		.selectAll(".tick text")
		.style("fill", "#777")
		.style("visibility", (d, i, nodes) => {
			if (i === 0) {
				return "hidden";
			} else {
				return "visible";
			}
		});

	// Add vertical gridlines
	svg.selectAll("xGrid")
		.data(x.ticks().slice(1))
		.join("line")
		.attr("x1", d => x(d))
		.attr("x2", d => x(d))
		.attr("y1", 0)
		.attr("y2", height)
		.attr("stroke", "#D5DBF0")
		.attr("stroke-width", .5);

	// // Add horizontal gridlines

	svg.selectAll("yGrid")
		.data(y.ticks((d3.max(data, d => d.population) - 65000) / 5000).slice(1))
		.join("line")
		.attr("x1", 0)
		.attr("x2", width)
		.attr("y1", d => y(d))
		.attr("y2", d => y(d))
		.attr("stroke", "#D5DBF0")
		.attr("stroke-width", 1)

	// Create the line generator

	const line = d3.line()
		.x(d => x(d.date))
		.y(d => y(d.population));

	// Add the line path to the SVG element

	var groupdata = d3.group(data, (d) => d.line);

	// color palette
	var res = groupdata.keys() // list of group names
	var color = d3.scaleOrdinal()
		.domain(res)
		.range(['#fd9332', '#7091f5', 'green', 'yellow', 'pink'])

	var lablePading = 0;

	groupdata.forEach((value, key) => {
		console.log(value, key)
		svg.append("path")
			.datum(value)
			.attr("fill", "none")
			.attr("stroke", color(key))
			.attr("stroke-width", 2)
			.attr("d", line);
		//
		let paddingForText = -7;
		svg.append("g").selectAll("text")
			.data(value)
			.enter()
			.append("text")
			.attr("x", function (d) { return x(d.date) + paddingForText })
			.attr("y", function (d) { return y(d.population) + paddingForText })
			.attr("fill", color(key))
			.text(function (d) { return d.population })
			.style("font-family", "Montserrat")
			.style("font-size", "10px")
			.style("font-weight", "600");

		svg.append("g")
			.append("rect")
			.attr("class", 'rectangleLegent')
			.attr("x", (lablePading))
			.attr("y", -25)
			.attr("width", 20)
			.attr("height", 10)
			.attr("fill", color(key))
			.attr("rx",5 )
			.attr("stroke", "rgb(224, 224, 224)")
			.attr("stroke-width", "0.5");

			

		svg.append("text")
			.attr("class", "chart-title")
			.attr("x", (lablePading) + 30)
			.attr("y", -15)
			.style("font-size", "16px")
			.style("font-weight", "bold")
			.style("font-family", "Montserrat")
			.style("fill", "#414141")
			.text(key);
		lablePading = lablePading + (width / groupdata.size);
	})


}