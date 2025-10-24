import SwiftUI

struct HabitDetailView: View {
    @Binding var habit: Habit
    var onSave: (() -> Void)?  // isteğe bağlı kaydetme callback'i

    var body: some View {
        VStack {
            Text(habit.title)
                .font(.largeTitle)
                .padding()

            Button("Bugünü Tamamla") {
                let today = Calendar.current.startOfDay(for: Date())
                if !habit.completedDays.contains(today) {
                    habit.completedDays.append(today)
                    onSave?() // ana ekrandan gelen kaydetme fonksiyonunu çağır
                }
            }
            .padding()
            .buttonStyle(.borderedProminent)

            List(habit.completedDays, id: \.self) { date in
                Text(date.formatted(date: .abbreviated, time: .omitted))
            }

            Spacer()
        }
        .navigationTitle("Alışkanlık Takibi")
    }
}
