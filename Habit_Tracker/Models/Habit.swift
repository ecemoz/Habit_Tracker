import Foundation
//Alışkanlık Modelim
struct Habit: Identifiable, Codable { // Modelimin adı Habit.Benzersiz bir kimliği var, kaydetmek ve geri dönüştürmeye de izin veriyor.
    let id = UUID() // Benzersiz bir id si her alışkanlığımın olmalı.
    var title: String
    var completedDays: [Date] = []
}
