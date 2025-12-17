//
//  TopicsLoaderService.swift
//  AlgoZavr
//
//  Created by Никита Поскрёбышев on 16.12.2025.
//


import Foundation

final class TopicsLoaderServiceManual: TopicsLoaderService {
    func loadTopics() async throws -> [Topic] {
        [
            Topic(
                id: "1",
                title: "Сортировки",
                algorithms: [
                    "Пузырьковая сортировка (Bubble Sort)",
                    "Сортировка вставками (Insertion Sort)",
                    "Сортировка выбором (Selection Sort)",
                    "Сортировка слиянием (Merge Sort)",
                    "Быстрая сортировка (Quick Sort)",
                    "Сортировка подсчётом (Counting Sort)"
                ]
            ),
            
            Topic(
                id: "2",
                title: "Поиски",
                algorithms: [
                    "Линейный поиск",
                    "Бинарный поиск",
                    "Ternary Search",
                    "Интерполяционный поиск"
                ]
            ),
            
            Topic(
                id: "3",
                title: "Структуры данных",
                algorithms: [
                    "Хеш-таблица (HashMap / HashSet)",
                    "Двоичное дерево поиска (BST)",
                    "AVL-дерево",
                    "Красно-чёрное дерево",
                    "Splay-дерево",
                    "Treap",
                    "Fenwick Tree (Дерево Фенвика)",
                    "Segment Tree",
                    "Sparse Table",
                    "Disjoint Set Union (Union-Find)"
                ]
            ),
            
            Topic(
                id: "4",
                title: "Графы — обходы и базовые алгоритмы",
                algorithms: [
                    "BFS (Поиск в ширину)",
                    "DFS (Поиск в глубину)",
                    "Топологическая сортировка",
                    "Поиск мостов",
                    "Поиск точек сочленения",
                    "Компоненты связности",
                    "Компоненты сильной связности (Kosaraju)",
                    "Алгоритм Тарьяна для SCC",
                    "Поиск циклов",
                    "Дерево Гомори–Ху"
                ]
            ),
            
            Topic(
                id: "5",
                title: "Кратчайшие пути",
                algorithms: [
                    "Алгоритм Дейкстры",
                    "Алгоритм Беллмана–Форда",
                    "Флойд–Уоршелл",
                    "Алгоритм Джонсона",
                    "0–1 BFS"
                ]
            ),
            
            Topic(
                id: "6",
                title: "Минимальные остовные деревья",
                algorithms: [
                    "Краскал",
                    "Прим",
                    "Борувка",
                    "MST D&C",
                    "LCA + RMQ в MST-задачах"
                ]
            ),
            
            Topic(
                id: "7",
                title: "Динамическое программирование",
                algorithms: [
                    "DP по массиву",
                    "DP по подмножествам (Bitmask DP)",
                    "DP на дереве",
                    "DP на DAG",
                    "Knapsack (0/1, bounded, unbounded)",
                    "LIS (Longest Increasing Subsequence)",
                    "DP по строкам (LCS, LPS)",
                    "Meet-in-the-middle"
                ]
            ),
            
            Topic(
                id: "8",
                title: "Строковые алгоритмы",
                algorithms: [
                    "Префикс-функция (KMP)",
                    "Z-функция",
                    "Рабин–Карп",
                    "Суффиксный массив",
                    "Суффиксное дерево (Ukkonen)",
                    "LCP массив (Kasai)",
                    "Aho–Corasick",
                    "Rolling Hash",
                    "Two-pointer + sliding window"
                ]
            ),
            
            Topic(
                id: "9",
                title: "Теория чисел",
                algorithms: [
                    "Быстрое возведение в степень",
                    "Решето Эратосфена",
                    "Segmented Sieve",
                    "GCD + расширенный GCD",
                    "Алгоритм Евклида",
                    "Китайская теорема об остатках",
                    "Факторизация (Pollard Rho)",
                    "Функция Эйлера φ",
                    "Комбинаторика на модуле (nCr, факториалы)"
                ]
            ),
            
            Topic(
                id: "10",
                title: "Геометрия",
                algorithms: [
                    "Проверка пересечения отрезков",
                    "Convex Hull — Graham Scan",
                    "Convex Hull — Andrew monotone chain"
                ]
            ),
            
            Topic(
                id: "11",
                title: "Жадные алгоритмы",
                algorithms: [
                    "Activity Selection",
                    "Алгоритм Хаффмана",
                    "Interval Scheduling",
                    "Job Sequencing",
                    "Coin Greedy (минимум монет)"
                ]
            )
        ]
    }
}
