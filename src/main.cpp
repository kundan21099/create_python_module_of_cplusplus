/*
 * main.cpp
 *
 *  Created on: 14-Dec-2025
 *      Author: Kundan
 */


#include <CPlusPlusClass.h>
#include<iostream>

int main(){
	CPlusPlusClass obj = CPlusPlusClass(10,10);
	int result = obj.addition();
	std::cout<< "Result: " << result << std::endl;

	return 0;
}
