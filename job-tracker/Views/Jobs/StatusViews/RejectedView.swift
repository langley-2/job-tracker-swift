//
//  RejectedView.swift
//  job-tracker
//
//  Created by Langley Millard on 4/5/2025.
//


import SwiftUI

struct RejectedView: View {
    let job: Job
    @ObservedObject var jobStore: JobStore
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Section(header: Text("Application Status").font(.headline)) {
                VStack(alignment: .leading, spacing: 8) {
                    Text("Status: Application rejected")
                    Text("Date: \(job.date, formatter: dateFormatter)")
                }
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(8)
            }
            
            Section(header: Text("Reflection").font(.headline)) {
                VStack(alignment: .leading, spacing: 8) {
                    Text("It's okay! Each application is a learning experience.")
                    Text("Consider what you might improve for future applications.")
                    Text("Remember to keep track of any feedback received.")
                }
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(8)
            }
            
            Spacer()
            
            Button("Delete Application") {
                // In a real app, you'd add confirmation before deletion
                jobStore.deleteJob(job)
            }
            .buttonStyle(.bordered)
            .foregroundColor(.red)
            .frame(maxWidth: .infinity)
        }
    }
    
    private var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter
    }
}