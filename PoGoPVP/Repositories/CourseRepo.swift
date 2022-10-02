//
//  CourseRepo.swift
//  PoGoPVP
//
//  Created by Anthony Stanners on 28/09/2022.
//

import Foundation

struct CourseRepo {
    var name: String = ""
    var courses: [String: Course] = [:]

    mutating func addCourse( courseName: String, course: Course ) -> Void {
        courses[name] = course
    }
    
    func getCourseNamed( name: String) -> Course? {
        return courses[ name ]
    }
    
}
