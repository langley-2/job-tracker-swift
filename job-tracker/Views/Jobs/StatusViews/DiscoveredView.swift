//
//  DiscoveredView.swift
//  job-tracker
//
//  Created by Langley Millard on 4/5/2025.
//


import SwiftUI

struct DiscoveredView: View {
    let job: Job
    @ObservedObject var jobStore: JobStore
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("You haven't applied to this job yet.")
                .font(.headline)
            
            VStack(alignment: .leading, spacing: 12) {
                Text("Job Details")
                    .font(.title3)
                    .bold()
                
                VStack(alignment: .leading, spacing: 8) {
                    Text("Position: \(job.jobTitle)")
                    Text("Company: \(job.orgName)")
                    Text("Added on: \(job.date, formatter: dateFormatter)")
                }
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(8)
            }
            
            Spacer()
            
            Button("Mark as Applied") {
                var updatedJob = job.updated(
                    hasApplied: true,
                    status: .applied
                )
                jobStore.updateJob(updatedJob)
            }
            .buttonStyle(.borderedProminent)
            .frame(maxWidth: .infinity)
        }
    }
    
    private var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter
    }
}