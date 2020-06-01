#include <iostream>
#include <gtest/gtest.h>
#include <Calculator/Calculator.h>
using namespace std;

TEST(CalculatorTest, CalcSum) {
	EXPECT_EQ(Sum(1, 1), 2);
	EXPECT_EQ(Sum(1, 2), 3);
}

int main(int argc, char **argv)
{
	::testing::InitGoogleTest(&argc, argv);
	return RUN_ALL_TESTS();
}