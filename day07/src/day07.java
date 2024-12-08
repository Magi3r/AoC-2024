
import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.stream.Collectors;

public class day07 {

    public static void main(String[] args) throws IOException {
        var input = prepare(args[0]);
        System.out.println("Part 1: " + part1(input));
        System.out.println("Part 2: " + part2(input));
    }

    private static ArrayList<ArrayList<Long>> prepare(String path) throws IOException {
        ArrayList<ArrayList<Long>> input = new ArrayList<>();

        try (BufferedReader br = new BufferedReader(new FileReader(path))) {
            String line = br.readLine();

            while (line != null) {
                input.add(new ArrayList<>(
                        Arrays.stream(line.split(":? ")).map(Long::valueOf).collect(Collectors.toList())));
                line = br.readLine();
            }
        }
        return input;
    }

    private static List<Long> calculatePossibleValues(List<Long> values) {
        if (values.size() < 2)
            return values;

        var possibleValues = new ArrayList<Long>();

        var subList = new ArrayList<>(values.subList(2, values.size()));
        subList.addFirst(values.get(0) + values.get(1));
        possibleValues.addAll(calculatePossibleValues(subList));

        subList = new ArrayList<>(values.subList(2, values.size()));
        subList.addFirst(values.get(0) * values.get(1));
        possibleValues.addAll(calculatePossibleValues(subList));

        return possibleValues;
    }

    private static Long part1(ArrayList<ArrayList<Long>> input) {
        var result = 0l;
        for (ArrayList<Long> equation : input) {
            var target = equation.getFirst();
            var possibleValues = calculatePossibleValues(equation.subList(1, equation.size()));
            if (possibleValues.contains(target)) {
                result += target;
            }
        }
        return result;
    }

    private static List<Long> calculatePossibleValues2(List<Long> values) {
        if (values.size() < 2)
            return values;

        var possibleValues = new ArrayList<Long>();

        var subList = new ArrayList<>(values.subList(2, values.size()));
        subList.addFirst(values.get(0) + values.get(1));
        possibleValues.addAll(calculatePossibleValues2(subList));

        subList = new ArrayList<>(values.subList(2, values.size()));
        subList.addFirst(values.get(0) * values.get(1));
        possibleValues.addAll(calculatePossibleValues2(subList));

        subList = new ArrayList<>(values.subList(2, values.size()));
        subList.addFirst(Long.valueOf(values.get(0).toString() + values.get(1).toString()));
        possibleValues.addAll(calculatePossibleValues2(subList));

        return possibleValues;
    }

    private static Long part2(ArrayList<ArrayList<Long>> input) {
        var result = 0l;
        for (ArrayList<Long> equation : input) {
            var target = equation.getFirst();
            var possibleValues = calculatePossibleValues2(equation.subList(1, equation.size()));
            if (possibleValues.contains(target)) {
                result += target;
            }
        }
        return result;
    }

}