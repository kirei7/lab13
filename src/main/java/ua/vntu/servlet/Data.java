package ua.vntu.servlet;

import java.util.*;
import java.util.Map.Entry;

public class Data {
    private Map<Country, Integer> data;

    public List<Country> getResultsByYear(int year) {
        return results.get(year);
    }

    public Map<Integer, List<Country>> getResults() {
        return results;
    }
    private Map<Integer, List<Country>> results;
    public Data() {
        results = new HashMap<>();
        results.put(
                2016,
                Arrays.asList(
                        Country.UKRAINE,
                        Country.AUSTRALIA,
                        Country.RUSSIA,
                        Country.BULGARIA,
                        Country.SWEDEN,
                        Country.FRANCE,
                        Country.ARMENIA,
                        Country.POLAND,
                        Country.LITHUANIA,
                        Country.BELGIUM

                )
        );
        results.put(
                2015,
                Arrays.asList(
                        Country.SWEDEN,
                        Country.RUSSIA,
                        Country.ITALY,
                        Country.BELGIUM,
                        Country.AUSTRALIA,
                        Country.LATVIA,
                        Country.ESTONIA,
                        Country.NORWAY,
                        Country.ISRAEL,
                        Country.SERBIA

                )
        );


        data = new HashMap<>();
        for (Country country : Country.values()) {
            int count = 0;
            for (Entry<Integer, List<Country>> entry : results.entrySet()) {
                if (entry.getValue().contains(country)) {
                    count++;
                }
            }
            data.put(country, count);
        }
    }
    public Map getChartData() {
        return data;
    }

    public enum Country {
        UKRAINE("Україна"),
        AUSTRALIA("Австралія"),
        RUSSIA("Росія"),
        BULGARIA("Болгарія"),
        SWEDEN("Швеція"),
        FRANCE("Франція"),
        ARMENIA("Вірменія"),
        POLAND("Польща"),
        LITHUANIA("Литва"),
        BELGIUM("Бельгія"),

        ITALY("Італія"),
        LATVIA("Латвія"),
        ESTONIA("Естонія"),
        NORWAY("Норвегія"),
        ISRAEL("Ізраїль"),
        SERBIA("Сербія")
        ;
        private String name;

        Country(String name) {
            this.name = name;
        }

        @Override
        public String toString() {
            return name;
        }
    }
}
