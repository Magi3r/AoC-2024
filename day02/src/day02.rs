use std::option::Option;
use std::str::Lines;

fn prepare(path: &String) -> Vec<Vec<i32>> {
    let input: String = std::fs::read_to_string(path).unwrap();
    let lines: Lines = input.lines();
    let mut reports: Vec<Vec<i32>> = Vec::new();
    for line in lines {
        reports.push(
            line.split_whitespace()
                .map(|i| i.parse::<i32>().unwrap())
                .collect(),
        );
    }
    return reports;
}

fn diff_from_report(report: &Vec<i32>) -> Vec<i32> {
    let mut diff: Vec<i32> = Vec::new();
    for i in 0..report.len() - 1 {
        diff.push(report[i] - report[i + 1]);
    }
    return diff;
}

fn part1(reports: &Vec<Vec<i32>>) -> i32 {
    let mut safe_count = 0;
    for report in reports {
        let mut is_safe = true;
        let mut increasing: Option<bool> = None;
        for i in 0..report.len() - 1 {
            let diff = report[i] - report[i + 1];
            if 0 < diff && diff <= 3 {
                if increasing == None {
                    increasing = Some(false)
                } else if increasing == Some(true) {
                    is_safe = false;
                    break;
                }
            } else {
                let diff = report[i + 1] - report[i];
                if 0 < diff && diff <= 3 {
                    if increasing == None {
                        increasing = Some(true)
                    } else if increasing == Some(false) {
                        is_safe = false;
                        break;
                    }
                } else {
                    is_safe = false;
                    break;
                }
            }
        }
        if is_safe {
            safe_count += 1;
        }
    }
    return safe_count;
}

fn is_safe_report(diff: &Vec<i32>) -> bool {
    let mut increasing: Option<bool> = None;
    for i in 0..diff.len() {
        if diff[i] > 3 || diff[i] < -3 || diff[i] == 0 {
            return false;
        }
        if diff[i] > 0 {
            if increasing == Some(false) {
                return false;
            }
            increasing = Some(true);
        }
        if diff[i] < 0 {
            if increasing == Some(true) {
                return false;
            }
            increasing = Some(false);
        }
    }
    return true;
}

fn part2(reports: &Vec<Vec<i32>>) -> i32 {
    let mut safe_count = 0;
    for report in reports {
        let diff = diff_from_report(report);
        if is_safe_report(&diff) {
            safe_count += 1;
        } else {
            // dampener
            for i in 0..report.len() {
                let mut dampened_report = report.clone();
                dampened_report.remove(i);
                let dampened_diff=diff_from_report(&dampened_report);
                
                if is_safe_report(&dampened_diff) {
                    safe_count += 1;
                    break;
                }
            }
        }
    }
    return safe_count;
}

fn main() {
    let args: Vec<String> = std::env::args().collect();
    if args.len() == 2 {
        let reports: Vec<Vec<i32>> = prepare(&args[1]);
        println!("Part 1: {}", part1(&reports));
        println!("Part 2: {}", part2(&reports));
    } else {
        println!("Usage: {} <input-file>", args[0]);
    }
}

#[test]
fn test_part1() {
    let mut reports: Vec<Vec<i32>> = vec![vec![7, 6, 4, 2, 1]];
    assert_eq!(part1(&reports), 1);
    reports = vec![vec![1, 2, 7, 8, 9]];
    assert_eq!(part1(&reports), 0);
    reports = vec![vec![9, 7, 6, 2, 1]];
    assert_eq!(part1(&reports), 0);
    reports = vec![vec![1, 3, 2, 4, 5]];
    assert_eq!(part1(&reports), 0);
    reports = vec![vec![8, 6, 4, 4, 1]];
    assert_eq!(part1(&reports), 0);
    reports = vec![vec![1, 3, 6, 7, 9]];
    assert_eq!(part1(&reports), 1);
    reports = vec![
        vec![7, 6, 4, 2, 1],
        vec![1, 2, 7, 8, 9],
        vec![9, 7, 6, 2, 1],
        vec![1, 3, 2, 4, 5],
        vec![8, 6, 4, 4, 1],
        vec![1, 3, 6, 7, 9],
    ];
    assert_eq!(part1(&reports), 2);
}

#[test]
fn test_part2() {
    let mut reports: Vec<Vec<i32>> = vec![vec![7, 6, 4, 2, 1]];
    assert_eq!(part2(&reports), 1);
    reports = vec![vec![1, 2, 7, 8, 9]];
    assert_eq!(part2(&reports), 0);
    reports = vec![vec![9, 7, 6, 2, 1]];
    assert_eq!(part2(&reports), 0);
    reports = vec![vec![1, 3, 2, 4, 5]];
    assert_eq!(part2(&reports), 1);
    reports = vec![vec![8, 6, 4, 4, 1]];
    assert_eq!(part2(&reports), 1);
    reports = vec![vec![1, 3, 6, 7, 9]];
    assert_eq!(part2(&reports), 1);
    reports = vec![vec![20, 3, 6, 7, 9]];
    assert_eq!(part2(&reports), 1);
    reports = vec![vec![1, 3, 6, 7, 20]];
    assert_eq!(part2(&reports), 1);
    reports = vec![
        vec![7, 6, 4, 2, 1],
        vec![1, 2, 7, 8, 9],
        vec![9, 7, 6, 2, 1],
        vec![1, 3, 2, 4, 5],
        vec![8, 6, 4, 4, 1],
        vec![1, 3, 6, 7, 9],
    ];
    assert_eq!(part2(&reports), 4);
}
