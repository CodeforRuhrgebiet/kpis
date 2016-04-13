var mailinglistDataPoints = [];
var meetupDataPoints = [];
var twitterDataPoints = [];
var facebookDataPoints = [];
var kpis = [
  {
    type: "spline",
    showInLegend: true,
    name: "on mailinglist",
    color: "#22D790",
    dataPoints: mailinglistDataPoints
  },
  {
    type: "spline",
    showInLegend: true,
    name: "in meetup group",
    color: "#E0393E",
    dataPoints: meetupDataPoints
  },
  {
    type: "spline",
    showInLegend: true,
    name: "Twitter followers",
    color: "#79CCC9",
    dataPoints: twitterDataPoints
  },
  {
    type: "spline",
    showInLegend: true,
    name: "Facebook likes",
    color: "#3b5998",
    dataPoints: facebookDataPoints
  }
];

window.onload = function () {
  var overallChart = new CanvasJS.Chart('overallChart',
    {
      zoomEnabled: true,
      animationEnabled: true,
      legend: {
        horizontalAlign: "center",
        verticalAlign: "top"
      },
      axisY: {
        interlacedColor: "#F5F5F5",
        gridThickness: 0
      },
      //title:{ text: 'Code for Ruhrgebiet KPIs' },
      toolTip: {
        shared: "true"  //disable here.
      },
      data: kpis
    });

  var mailinglistRef = new Firebase("https://code-for-ruhrgebiet.firebaseio.com/kpis/mailinglist");
  var mailinglistQuery = mailinglistRef.orderByChild("timestamp").limitToLast(100);
  mailinglistQuery.on("value", function(snapshot) {
    snapshot.forEach(function(data) {
      var xValue = new Date(data.val().year, data.val().month - 1, data.val().day);
      var yValue = data.val().members_total_count;
      mailinglistDataPoints.push({ x: xValue, y : yValue });
    });
    overallChart.render();
  });

  var meetupRef = new Firebase("https://code-for-ruhrgebiet.firebaseio.com/kpis/meetup");
  var meetupQuery = meetupRef.orderByChild("timestamp").limitToLast(100);
  meetupQuery.on("value", function(snapshot) {
    snapshot.forEach(function(data) {
      var xValue = new Date(data.val().year, data.val().month - 1, data.val().day);
      var yValue = data.val().members_count;
      meetupDataPoints.push({ x: xValue, y : yValue });
    });
    overallChart.render();
  });

  var twitterRef = new Firebase("https://code-for-ruhrgebiet.firebaseio.com/kpis/twitter");
  var twitterQuery = twitterRef.orderByChild("timestamp").limitToLast(100);
  twitterQuery.on("value", function(snapshot) {
    snapshot.forEach(function(data) {
      var xValue = new Date(data.val().year, data.val().month - 1, data.val().day);
      var yValue = data.val().followers_count;
      twitterDataPoints.push({ x: xValue, y : yValue });
    });
    overallChart.render();
  });

  var facebookRef = new Firebase("https://code-for-ruhrgebiet.firebaseio.com/kpis/facebook");
  var facebookQuery = facebookRef.orderByChild("timestamp").limitToLast(100);
  facebookQuery.on("value", function(snapshot) {
    snapshot.forEach(function(data) {
      var xValue = new Date(data.val().year, data.val().month - 1, data.val().day);
      var yValue = data.val().likes_count;
      facebookDataPoints.push({ x: xValue, y : yValue });
    });
    overallChart.render();
  });
};
