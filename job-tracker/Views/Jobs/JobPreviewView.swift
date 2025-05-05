//
//  JobPreviewView.swift
//  job-tracker
//
//  Created by Langley Millard on 5/5/2025.
//

import SwiftUI

struct JobPreviewView: View {
    let job: Job
    @ObservedObject var jobStore: JobStore
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                // Header info
                VStack(alignment: .leading, spacing: 8) {
                    Text(job.jobTitle)
                        .font(.title)
                        .bold()
                    
                    Text(job.orgName)
                        .font(.title2)
                }
                .padding(.bottom)
                
                // Job details section
                if let jobLink = job.jobLink {
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Job Link")
                            .font(.headline)
                        
                        Link(jobLink.absoluteString, destination: jobLink)
                            .lineLimit(1)
                            .truncationMode(.middle)
                    }
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(8)
                }
                
                Spacer()
                
                // Save button
                Button(action: {
                    saveJobAsDiscovered()
                }) {
                    HStack {
                        Image(systemName: "plus.circle.fill")
                        Text("Save to My Jobs")
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                }
            }
            .padding()
        }
        .navigationBarTitleDisplayMode(.inline)
    }
    
    private func saveJobAsDiscovered() {
        // Create a copy of the job with status set to "discovered"
        let savedJob = job.updated(status: .discovered)
        
        // Add to job store
        jobStore.addJob(savedJob)
        
        // Display success alert or notification (you could add this)
        
        // Dismiss the view
        presentationMode.wrappedValue.dismiss()
    }
}