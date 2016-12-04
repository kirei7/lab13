<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="ua.vntu.servlet.Data,ua.vntu.servlet.Data.Country,java.util.Map,java.util.List,java.util.Map.Entry" %>
<html>
    <head>
        <title>Test webapp</title>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
        <link href="style.css" rel="stylesheet"/>
        <script src="jquery-3.1.1.min.js"></script>
        <script src="flot/jquery.flot.js"></script>
        <script src="flot/jquery.flot.pie.js"></script>
    </head>
    <body>
        <%
            Integer year;
            if (request.getParameter("year") == null || request.getParameter("year").isEmpty())
            {
                year = 2016;
            } else {
                year = Integer.parseInt(
                        request.getParameter("year")
                    );
            }
            Data dataProvider = new Data();
            Map<Country, Integer> chartData = dataProvider.getChartData();
            Map<Integer, List<Country>> results = dataProvider.getResults();
        %>
        <div class="demo-container">
            <div id="placeholder"></div>
        </div>
        <div class="stat-container">
                    <span>Показуються країни за
                        <%
                        out.print(year);
                        %>
                     рік
                    </span>
                    <ol>
                        <%
                            List<Country> countries = dataProvider.getResultsByYear(year);
                            String countriesOutput = "";
                            for(int i = 0; i < countries.size(); i++) {
                                countriesOutput += "<li>" +
                                countries.get(i) +
                                "</li>";
                            }
                            out.println(countriesOutput);
                        %>
                    </ol>
                    <form method="GET" action="index.jsp">
                        <select  name="year">
                            <%
                            String formOutput = "";
                                for(Entry<Integer, List<Country>> entry : results.entrySet()) {
                                    formOutput += "<option value=\"" + entry.getKey() + "\"";
                                    if(entry.getKey().equals(year)) {
                                        formOutput += "selected";
                                    }
                                    formOutput += ">" + entry.getKey() + "</option>";
                                }
                                out.println(formOutput);
                            %>
                        </select>
                        <p><input type="submit" value="Дивитись"></p>
                    </form>
                </div>
        <script type="text/javascript">
        var data = [
                <%
                    String output = "";
                    for (Entry<Country, Integer> entry : chartData.entrySet()) {
                    String countryName = entry.getKey().toString();
                        output +=
                        "{label: \"" +
                        countryName +
                        "- " + entry.getValue() + "\", data: " +
                        entry.getValue() +
                        "},";
                    }
                    output = output.substring(0, output.length()-1);
                    out.println(output);
                %>
            ];
            console.log(data);
            var placeholder = $("#placeholder");
            $.plot(placeholder, data, {
                series: {
                    pie: {
                        show: true
                    }
                },
                legend: {
                    sorted: "reverse"
                }
            });
        </script>
        <script type="text/javascript">
            function sort(arr) {
                var f;
                do {
                    f = false;
                    for(var i = 0; i < arr.length - 1; i++) {
                        if(arr[i].data < arr[i + 1].data) {
                        var temp = arr[i];
                        arr[i] = arr[i + 1];
                        arr[i + 1] = temp;
                        f = true;
                        }
                    }
                } while(f);
            }
        </script>
    </body>
</html>