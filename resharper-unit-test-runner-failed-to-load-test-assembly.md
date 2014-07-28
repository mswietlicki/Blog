Title: Resharper "Unit Test Runner failed to load test assembly"
Autor: Mateusz Świetlicki
CreateDate: 2014-07-28 13:50
Tags:	Blog
		EN
		Error
		.NET

Today I stepped on a odd resharper tests error. I run unit test using a test runner and received a Unit Test Runner failed to load test assembly exception.

![Unit Test Runner failed to load test assembly](/files/unit_test_runner_failed_to_run_tests.png)

It turned out I have unwittingly change Unit Test Sessions Framework combobox to CLR2.

![Framework set to CLR2](/files/unit_test_runner_failed_to_run_tests_framework.PNG)

Problem was resolved after changing but to Framework: Auto.